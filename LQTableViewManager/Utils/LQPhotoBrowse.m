//
//  LQPhotoBrowse.m
//  Pods
//
//  Created by LittleQ on 2019/3/29.
//

#import "LQPhotoBrowse.h"
#import "LQConfig.h"
#import "UIImageView+WebCache.h"
#import "SDWebImagePrefetcher.h"
#import <ImageIO/ImageIO.h>
#import "LQPhotoBrowseCell.h"
#import "LQPhotoBrowseNumView.h"
#import "KNActionSheet.h"
#import "NSBundle+RETableViewManager.h"

@interface LQPhotoBrowse()<UICollectionViewDataSource,UICollectionViewDelegate> {
  LQPhotoBrowseCell     *_collectionViewCell;
  LQPhotoBrowseNumView  *_numView;
  UICollectionView      *_collectionView;
  UIButton              *_operationBtn;
  UIPageControl         *_pageControl;
  BOOL                   _isFirstShow;
  CGFloat                _contentOffsetX;
  NSInteger              _page;
  NSArray               *_tempArr;
}

@end

static NSString *ID = @"LQCollectionView";

@implementation LQPhotoBrowse

- (instancetype)init{
  if (self = [super init]) {
    [self initializeDefaultProperty];
  }
  return self;
}

#pragma mark - init Default
- (void)initializeDefaultProperty{
  [self setBackgroundColor:[UIColor blackColor]];
  [self setAlpha:PhotoBrowseBackgroundAlpha];

  self.actionSheetArr = [NSMutableArray array];
  _isNeedPageNumView      = YES;
  _isNeedRightTopBtn      = YES;
  _isNeedPictureLongPress = YES;
  _isNeedPageControl      = NO;
}



#pragma mark - init CollectionView
- (void)initializeCollectionView{

  CGRect bounds = (CGRect){{0,0},{self.frame.size.width,self.frame.size.height}};
  bounds.size.width += PhotoBrowseMargin;

  // 1.create layout
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  [layout setItemSize:bounds.size];
  [layout setMinimumInteritemSpacing:0];
  [layout setMinimumLineSpacing:0];
  [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];

  // 2.create collectionView
  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:bounds collectionViewLayout:layout];

  [collectionView setBackgroundColor:[UIColor clearColor]];
  [collectionView setPagingEnabled:YES];
  [collectionView setBounces:YES];

  [collectionView setDataSource:self];
  [collectionView setDelegate:self];

  [collectionView setShowsHorizontalScrollIndicator:NO];
  [collectionView setShowsVerticalScrollIndicator:NO];
  [collectionView setDecelerationRate:0];
  [collectionView registerClass:[LQPhotoBrowseCell class] forCellWithReuseIdentifier:ID];
  _collectionView = collectionView;

  [self addSubview:collectionView];
}

#pragma mark - init pageView
- (void)initializePageView{
  LQPhotoBrowseNumView *numView = [[LQPhotoBrowseNumView alloc] init];
  [numView setFrame:(CGRect){{0,25},{ScreenWidth,25}}];
  [numView setCurrentNum:(_currentIndex + 1) totalNum:_itemsArr.count];
  _page = [numView currentNum];
  [numView setHidden:!_isNeedPageNumView];

  // has only one picture page number will be hidden.
  if(_itemsArr.count == 1){
    [numView setHidden:YES];
  }

  _numView = numView;
  [self addSubview:numView];
}

#pragma mark - init UIPageControl
- (void)initializePageControl{
  UIPageControl *pageControl = [[UIPageControl alloc] init];
  [pageControl setCurrentPage:_currentIndex];
  [pageControl setNumberOfPages:_itemsArr.count];
  [pageControl setFrame:(CGRect){{0,ScreenHeight - 50},{ScreenWidth,30}}];
  [pageControl setHidden:!_isNeedPageControl];

  // has only one picture page controll will be hidden.
  if(_itemsArr.count == 1){
    [pageControl setHidden:YES];
  }

  _pageControl = pageControl;
  [self addSubview:pageControl];
}

#pragma mark - init Operation
- (void)initializeOperationView{
  UIButton *operationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [operationBtn.layer setCornerRadius:3];
  [operationBtn.layer setMasksToBounds:YES];
  [operationBtn setBackgroundColor:[UIColor blackColor]];
  [operationBtn setAlpha:0.4];
  [operationBtn setBackgroundImage:[UIImage imageNamed:@"image_more_tap@2x" inBundle:[NSBundle RETableViewManagerBundle] compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
  [operationBtn setFrame:(CGRect){{ScreenWidth - 35 - 15,25},{35,20}}];
  [operationBtn addTarget:self action:@selector(operationBtnIBAction) forControlEvents:UIControlEventTouchUpInside];
  [operationBtn setHidden:!_isNeedRightTopBtn];
  _operationBtn = operationBtn;
  [self addSubview:operationBtn];
}

#pragma mark - Operation tap
- (void)operationBtnIBAction{

  NSLog(@"Click it.");

  __weak typeof(self) weakSelf = self;

//    if(!_isNeedPictureLongPress) return;

  KNActionSheet *actionSheet = [[KNActionSheet alloc] initWithCancelTitle:nil destructiveTitle:@"删除" otherTitleArr:@[@"保存图片",@"转发微博",@"赞"]  actionBlock:^(NSInteger buttonIndex) {
    // Notification Delegate
    if([weakSelf.delegate respondsToSelector:@selector(photoBrowseRightOperationActionWithIndex:)]){
      [weakSelf.delegate photoBrowseRightOperationActionWithIndex:buttonIndex];
    }

  }];
  [actionSheet show];
}

- (void)deleteImageIBAction{
  NSMutableArray *tempArr = [NSMutableArray arrayWithArray:_itemsArr];
  [tempArr removeObjectAtIndex:(NSUInteger) _currentIndex];
  _itemsArr = [tempArr copy];
  [_collectionView reloadData];

  if(_itemsArr.count == 0){
    [_numView setCurrentNum:_currentIndex totalNum:_itemsArr.count];
    [_collectionView setHidden:YES];
    [_operationBtn   setHidden:YES];
    [_pageControl    setHidden:YES];
    [_numView        setHidden:YES];
    [self removeFromSuperview];
  }else{
    [_numView setCurrentNum:(_currentIndex + 1) totalNum:_itemsArr.count];
  }
}

#pragma mark - save photo to album, only callback this.
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{

}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return _itemsArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

  __weak typeof(self) weakSelf = self;
  LQPhotoBrowseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

  LQPhotoItems *items = _itemsArr[(NSUInteger) indexPath.row];
  NSString *url = items.url;

  UIImageView *tempView = [weakSelf tempViewFromSourceViewWithCurrentIndex:indexPath.row];

  [cell sd_ImageWithUrl:url placeHolder:tempView.image?tempView.image:nil];

  cell.singleTap = ^(){
    [weakSelf dismiss];
  };

  cell.longPress = ^(){
    [weakSelf longPressIBAction];
  };

  _collectionViewCell = cell;
  cell.backgroundColor = [UIColor clearColor];
  return cell;
}


- (void)longPressIBAction{
  if(!_isNeedPictureLongPress) return;
  [self operationBtnIBAction];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  _currentIndex = (NSInteger) (scrollView.contentOffset.x / (ScreenWidth + PhotoBrowseMargin));

  CGFloat scrollViewW = scrollView.frame.size.width;
  CGFloat x = scrollView.contentOffset.x;
  NSInteger page = (NSInteger) ((x + scrollViewW / 2) / scrollViewW);

  if(_page != page){
    _page = page;
    if(_page + 1 <= _itemsArr.count){
      [_numView setCurrentNum:_page + 1];
      [_pageControl setCurrentPage:_page];
    }
  }
}

#pragma mark - move to parent component.
- (void)willMoveToSuperview:(UIView *)newSuperview{
  [self initializeCollectionView];
  [self initializePageView];
  [self initializePageControl];
  [self initializeOperationView];
}

#pragma mark - present
- (void)present{
  if([self imageArrayIsEmpty:_itemsArr]){
    return;
  }

  if(![self imageArrayIsEmpty:_dataSourceUrlArr]){
    NSArray *arr = [_dataSourceUrlArr subarrayWithRange:NSMakeRange(_itemsArr.count, _dataSourceUrlArr.count -_itemsArr.count)];
    NSMutableArray *Arrs = [NSMutableArray arrayWithArray:_itemsArr];
    [Arrs addObjectsFromArray:arr];
    _itemsArr = [Arrs copy];
  }

  UIWindow *window = [[UIApplication sharedApplication] keyWindow];
  [self setFrame:window.bounds];
  [window addSubview:self];
}

#pragma mark - dismiss
- (void)dismiss{
  // Notification Delegate PhotoBrowse will dismiss.
  if([self.delegate respondsToSelector:@selector(photoBrowseWillDismiss)]){
    [self.delegate photoBrowseWillDismiss];
  }

  UIImageView *tempView = [[UIImageView alloc] init];
  SDWebImageManager *mgr = [SDWebImageManager sharedManager];

  LQPhotoItems *items = _itemsArr[(NSUInteger) _currentIndex];
  tempView.contentMode = items.sourceView.contentMode;

  [mgr diskImageExistsForURL:[NSURL URLWithString:items.url] completion:^(BOOL isInCache) {
    if (isInCache) {
      if([[[[items.url lastPathComponent] pathExtension] lowercaseString] isEqualToString:@"gif"]){ // special for git
        NSData *data = UIImageJPEGRepresentation([[mgr imageCache] imageFromDiskCacheForKey:items.url], 1.f);
        tempView.image = [self imageFromGifFirstImage:data]; // get first frame for gif.
      }else{ // common picture.
        tempView.image = [[mgr imageCache] imageFromDiskCacheForKey:items.url];
      }
    } else {
      UIImage *image = [[self tempViewFromSourceViewWithCurrentIndex:_currentIndex] image];
      if(image){
        [tempView setImage:image];
      }else{
        [tempView setImage:items.sourceImage];
      }
    }
  }];

  if(!tempView.image){
    [tempView setImage:[self createImageWithUIColor:PhotoShowPlaceHolderImageColor]];
  }

  [_collectionView setHidden:YES];
  [_operationBtn   setHidden:YES];
  [_pageControl    setHidden:YES];
  [_numView        setHidden:YES];

  _itemsArr = nil;

  UIView *sourceView;
  if([_sourceViewForCellReusable isKindOfClass:[UICollectionView class]]){
    sourceView = [(UICollectionView *)_sourceViewForCellReusable cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
  }else{
    sourceView = items.sourceView;
  }

  CGRect rect = [sourceView convertRect:[sourceView bounds] toView:self];

  if(rect.origin.y > ScreenHeight ||
      rect.origin.y <= - rect.size.height ||
      rect.origin.x > ScreenWidth ||
      rect.origin.x <= -rect.size.width
      ){
    [UIView animateWithDuration:PhotoBrowseBrowseTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
      [tempView setAlpha:0.f];
      [self setBackgroundColor:[UIColor clearColor]];
    } completion:^(BOOL finished) {
      [tempView removeFromSuperview];
      [UIView animateWithDuration:0.15 animations:^{
        [tempView setAlpha:0.f];
      } completion:^(BOOL finished) {
        [self removeFromSuperview];
      }];
    }];
  }else{
    CGFloat width  = tempView.image.size.width;
    CGFloat height = tempView.image.size.height;

    CGSize tempRectSize = (CGSize){ScreenWidth,(height * ScreenWidth / width) > ScreenHeight ? ScreenHeight:(height * ScreenWidth / width)};

    [tempView setBounds:(CGRect){CGPointZero,{tempRectSize.width,tempRectSize.height}}];
    [tempView setCenter:[self center]];
    [self addSubview:tempView];

    [UIView animateWithDuration:PhotoBrowseBrowseTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
      [tempView setFrame:rect];
      [self setBackgroundColor:[UIColor clearColor]];
    } completion:^(BOOL finished) {
      [UIView animateWithDuration:0.15 animations:^{
        [tempView setAlpha:0.f];
      } completion:^(BOOL finished) {
        [self removeFromSuperview];
      }];
    }];
  }
}

#pragma mark - When Showing Animation
- (void)photoBrowseWillShowWithAnimated{
  // 0. init data.
  _tempArr = [NSArray arrayWithArray:_itemsArr];

  // 1. check user click the index of picture. setting collection view offset.
  [_collectionView setContentOffset:(CGPoint){_currentIndex * (self.frame.size.width + PhotoBrowseMargin),0} animated:NO];
  _contentOffsetX = _collectionView.contentOffset.x;

  // 2. self.sourceView include 'button' using UIView to receive.
  LQPhotoItems *items = _itemsArr[(NSUInteger) _currentIndex];

  UIView *sourceView;
  if([_sourceViewForCellReusable isKindOfClass:[UICollectionView class]]){
    sourceView = [(UICollectionView *)_sourceViewForCellReusable cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
  }else{
    sourceView = items.sourceView;
  }

  CGRect rect = [sourceView convertRect:[sourceView bounds] toView:self];

  UIImageView *tempView = [self tempViewFromSourceViewWithCurrentIndex:_currentIndex];

  [tempView setFrame:rect];
  [tempView setContentMode:sourceView.contentMode];
  [self addSubview:tempView];

  CGSize tempRectSize;

  CGFloat width = tempView.image.size.width;
  CGFloat height = tempView.image.size.height;

  tempRectSize = (CGSize){ScreenWidth,(height * ScreenWidth / width) > ScreenHeight ? ScreenHeight:(height * ScreenWidth / width)};

  [_collectionView setHidden:YES];

  [UIView animateWithDuration:PhotoBrowseBrowseTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    [tempView setCenter:[self center]];
    [tempView setBounds:(CGRect){CGPointZero,tempRectSize}];
  } completion:^(BOOL finished) {
    _isFirstShow = YES;

    [UIView animateWithDuration:0.15 animations:^{
      [tempView setAlpha:0.f];
    } completion:^(BOOL finished) {
      [tempView removeFromSuperview];
    }];
    [_collectionView setHidden:NO];
  }];
}

#pragma mark - GET GIF Picture first frame.
- (UIImage *)imageFromGifFirstImage:(NSData *)data{
  CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
  size_t count = CGImageSourceGetCount(source);

  UIImage *sourceImage;
  if(count <= 1){
    CFRelease(source);
    sourceImage = [[UIImage alloc] initWithData:data];
  }else{
    CGImageRef image = CGImageSourceCreateImageAtIndex(source, 0, NULL);
    sourceImage = [UIImage imageWithCGImage:image];
    CFRelease(source);
    CGImageRelease(image);
  }
  return sourceImage;
}

#pragma mark privave method :  convert sub component to ImageView
- (UIImageView *)tempViewFromSourceViewWithCurrentIndex:(NSInteger)currentIndex{
  // using for animation.
  UIImageView *tempView = [[UIImageView alloc] init];
  LQPhotoItems *items = _itemsArr[(NSUInteger) currentIndex];

  if([items.sourceView isKindOfClass:[UIImageView class]]){
    UIImageView *imgV = (UIImageView *)items.sourceView;
    [tempView setImage:[imgV image]];
  }

  if([items.sourceView isKindOfClass:[UIButton class]]){
    UIButton *btn = (UIButton *)items.sourceView;
    [tempView setImage:[btn currentBackgroundImage]?[btn currentBackgroundImage]:[btn currentImage]];
  }

  if([self imageArrayIsEmpty:_dataSourceUrlArr]){
    if(!tempView.image){
      [tempView setImage:[self createImageWithUIColor:PhotoShowPlaceHolderImageColor]];
    }
  }else{
    if([_sourceViewForCellReusable isKindOfClass:[UICollectionView class]]){
      UICollectionViewCell *cell = [(UICollectionView *)_sourceViewForCellReusable cellForItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0]];
      tempView.image = [(UIImageView *)cell.contentView.subviews[0] image];
    }

    if(!tempView.image){
      if(items.sourceImage && !items.url){
        tempView.image = items.sourceImage;
      }else{
        tempView.image = nil;
      }
    }
  }

  return tempView;
}

- (BOOL)imageArrayIsEmpty:(NSArray *)array{
  return array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0;
}

- (UIImage *)createImageWithUIColor:(UIColor *)imageColor{
  CGRect rect = CGRectMake(0, 0, 1.f, 1.f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [imageColor CGColor]);
  CGContextFillRect(context, rect);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

- (void)layoutSubviews{
  [super layoutSubviews];

  if(!_isFirstShow){
    [self photoBrowseWillShowWithAnimated];
  }
}

- (void)dealloc{
//
}

@end

@implementation LQPhotoItems

@end
