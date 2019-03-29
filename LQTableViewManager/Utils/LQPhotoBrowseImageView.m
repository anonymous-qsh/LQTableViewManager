//
//  LQPhotoBrowseImageView.m
//  Pods
//
//  Created by LittleQ on 2019/3/29.
//

#import "LQPhotoBrowseImageView.h"
#import "MBProgressHUD.h"
#import "LQConfig.h"
#import "UIImageView+WebCache.h"

@interface LQPhotoBrowseImageView () <UIScrollViewDelegate, MBProgressHUDDelegate> {
  NSURL *_url;
  UIImage *_placeHolder;
  MBProgressHUD *_aProgressHUD;
}

@property(nonatomic, strong) UILabel *reloadLabel;

@end

@implementation LQPhotoBrowseImageView

- (UIImageView *)imageView {
  if (!_imageView) {
    _imageView = [[UIImageView alloc] init];
    [_imageView setUserInteractionEnabled:YES];
    [_imageView setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
  }
  return _imageView;
}

- (UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [_scrollView addSubview:self.imageView];
    [_scrollView setDelegate:self];
    [_scrollView setClipsToBounds:YES];
  }
  return _scrollView;
}

- (UILabel *)reloadLabel {
  if (!_reloadLabel) {
    _reloadLabel = [[UILabel alloc] init];
    [_reloadLabel setBackgroundColor:[UIColor blackColor]];
    [_reloadLabel.layer setCornerRadius:5];
    [_reloadLabel setClipsToBounds:YES];
    [_reloadLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_reloadLabel setTextColor:[UIColor whiteColor]];
    [_reloadLabel setTextAlignment:NSTextAlignmentCenter];
    [_reloadLabel setBounds:(CGRect) {CGPointZero, {100, 35}}];
    [_reloadLabel setText:@"重新加载"];
    [_reloadLabel setCenter:(CGPoint) {(CGFloat) (ScreenWidth * 0.5), (CGFloat) (ScreenHeight * 0.5)}];
    [_reloadLabel setHidden:YES];
    [_reloadLabel setUserInteractionEnabled:YES];
    [_reloadLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadImageIBAction)]];
    [self addSubview:_reloadLabel];
  }
  return _reloadLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {

  if (self = [super initWithFrame:frame]) {
    [self addSubview:self.scrollView];
    [self initDefaultData];
  }
  return self;
}

- (void)initDefaultData {
  // 1. produce three gestures.
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDidTap)];
  UITapGestureRecognizer
      *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDidDoubleTap:)];
  UILongPressGestureRecognizer
      *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDidPress:)];

  // 2. setting gesture.
  [tap setNumberOfTapsRequired:1];
  [tap setNumberOfTouchesRequired:1];
  [doubleTap setNumberOfTapsRequired:2];
  [doubleTap setNumberOfTouchesRequired:1];

  // 3. avoid conflict.
  [tap requireGestureRecognizerToFail:doubleTap];

  // 4. add gesture.
  [self addGestureRecognizer:tap];
  [self addGestureRecognizer:doubleTap];
  [self addGestureRecognizer:longPress];
}

#pragma mark - singleClick
- (void)scrollViewDidTap {
  if (_singleTapBlock) {
    _singleTapBlock();
  }
}

#pragma mark - longPress
- (void)longPressDidPress:(UILongPressGestureRecognizer *)longPress {
  if (longPress.state == UIGestureRecognizerStateBegan) {
    if (_longPressBlock) {
      _longPressBlock();
    }
  }
}

#pragma mark - doubleClick
- (void)scrollViewDidDoubleTap:(UITapGestureRecognizer *)doubleTap {
  // check image is downloaded , if not return directly
  if (!_imageView.image)
    return;

  if (_scrollView.zoomScale <= 1) {
    // 1. get gestures position
    // 2.scrollView's offset x + picture x.
    CGFloat x = [doubleTap locationInView:self].x + _scrollView.contentOffset.x;

    // 3.scrollView's offset y + picture y.
    CGFloat y = [doubleTap locationInView:self].y + _scrollView.contentOffset.y;
    [_scrollView zoomToRect:(CGRect) {{x, y}, CGSizeZero} animated:YES];
  } else {
    // reduction picture.
    [_scrollView setZoomScale:1.f animated:YES];
  }
}

- (void)sd_ImageWithUrl:(NSURL *)url placeHolder:(UIImage *)placeHolder {
  _url = url;
  _placeHolder = placeHolder;

  if (!url) {
    [_imageView setImage:placeHolder];
    [self layoutSubviews];
    return;
  }

  __weak typeof(self) weakSelf = self;

  SDWebImageManager *mgr = [SDWebImageManager sharedManager];
  // get picture in cache.
  [[mgr imageCache] queryCacheOperationForKey:[url absoluteString] done:^(UIImage *_Nullable image,
                                                                          NSData *_Nullable data,
                                                                          SDImageCacheType cacheType) {
    if (_aProgressHUD) {
      // remove loading HUD
      [_aProgressHUD removeFromSuperview];
    }
    if (image) {
      // if image in cache, set it directly.
      _imageView.image = image;
      [weakSelf layoutSubviews];
    } else {
      // if image not in cache, download image
      // show loading HUD
      _aProgressHUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
      _aProgressHUD.mode = MBProgressHUDModeAnnularDeterminate;
      _aProgressHUD.delegate = self;
      // implementation hudWasHidden to clean object, to save memory.
      dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        // SDWebImage download image.
        [_imageView sd_setImageWithPreviousCachedImageWithURL:url placeholderImage:placeHolder options:SDWebImageRetryFailed progress:^(
            NSInteger receivedSize,
            NSInteger expectedSize,
            NSURL *_Nullable targetURL) {

          CGFloat progress = ((CGFloat) receivedSize / expectedSize);
          dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD HUDForView:self].progress = progress;
            if (progress == 1) {
              // download complete -> progress equal to 1
              if (!_aProgressHUD) {
                [_aProgressHUD removeFromSuperview];
              }
            }
          });
        }                                           completed:^(UIImage *_Nullable image,
                                                                NSError *_Nullable error,
                                                                SDImageCacheType cacheType,
                                                                NSURL *_Nullable imageURL) {
          [_scrollView setZoomScale:1.f animated:YES];
          if (error) {
            [_aProgressHUD removeFromSuperview];
            [weakSelf.reloadLabel setHidden:NO];
          } else {
            [weakSelf layoutSubviews];
          }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
          [_aProgressHUD hideAnimated:YES];
        });

      });
    }
  }];

}

#pragma mark -MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
  [hud removeFromSuperview];
  hud = nil;
}

- (void)reloadImageIBAction {
  [_reloadLabel setHidden:YES];
  [self sd_ImageWithUrl:_url placeHolder:_placeHolder];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _scrollView.frame = self.bounds;
  [self reloadFrames];
}

- (void)reloadFrames {
  CGRect frame = self.frame;
  if (_imageView.image) {

    CGSize imageSize = _imageView.image.size;
    CGRect imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);

    if (frame.size.width <= frame.size.height) {
      CGFloat ratio = frame.size.width / imageFrame.size.width;
      imageFrame.size.height = imageFrame.size.height * ratio;
      imageFrame.size.width = frame.size.width;

    } else {

      CGFloat ratio = frame.size.height / imageFrame.size.height;
      imageFrame.size.width = imageFrame.size.width * ratio;
      imageFrame.size.height = frame.size.height;
    }

    [_imageView setFrame:(CGRect) {CGPointZero, imageFrame.size}];

    _scrollView.contentSize = _imageView.frame.size;

    _imageView.center = [self centerOfScrollViewContent:_scrollView];

    CGFloat maxScale = frame.size.height / imageFrame.size.height;
    CGFloat widthRatio = frame.size.width / imageFrame.size.width;

    // get max scale
    maxScale = widthRatio > maxScale ? widthRatio : maxScale;
    maxScale = maxScale > PhotoBrowseImageMaxScale ? maxScale : PhotoBrowseImageMaxScale;

    // setting scrollView's max and min scale.
    _scrollView.minimumZoomScale = PhotoBrowseImageMinScale;
    _scrollView.maximumZoomScale = maxScale;

    // setting scrollView's original size.
    _scrollView.zoomScale = 1.0f;

  } else {
    frame.origin = CGPointZero;
    _imageView.frame = frame;
    _scrollView.contentSize = _imageView.frame.size;
  }
  _scrollView.contentOffset = CGPointZero;
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView {
  // scrollView.bounds.size.width > scrollView.contentSize.width
  CGFloat offsetX = (CGFloat) ((scrollView.bounds.size.width > scrollView.contentSize.width) ?
      (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0);

  CGFloat offsetY = (CGFloat) ((scrollView.bounds.size.height > scrollView.contentSize.height) ?
      (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0);

  CGPoint actualCenter = CGPointMake((CGFloat) (scrollView.contentSize.width * 0.5 + offsetX),
                                     (CGFloat) (scrollView.contentSize.height * 0.5 + offsetY));
  return actualCenter;
}

#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
  // every complete Drag and drop reset pic center point.
  _imageView.center = [self centerOfScrollViewContent:scrollView];
}

@end
