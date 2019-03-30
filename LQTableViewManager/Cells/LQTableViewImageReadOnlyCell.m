//
// LQTableViewImageReadOnlyCell.m
//
// Created by LittleQ on 2019-03-29.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "LQTableViewImageReadOnlyCell.h"
#import "UIImageView+WebCache.h"
#import "LQImageReadOnlyItem.h"
#import "UIColor+LQUtils.h"
#import "LQPhotoBrowse.h"
#import "MBProgressHUD.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define LTE_X(source, m) (source) < (m) ? (source) : (m)

@interface LQTableViewImageReadOnlyCell () <LQPhotoBrowseDelegate, MBProgressHUDDelegate> {
}

@property(nonatomic, strong) UIView *view;

@property(nonatomic, strong) NSMutableArray *itemsArray;
@property(nonatomic, strong) LQPhotoBrowse *photoBrowse;

@end

@implementation LQTableViewImageReadOnlyCell

@synthesize item = _item;

- (NSMutableArray *)itemsArray {
  if (!_itemsArray) {
    _itemsArray = [NSMutableArray array];
  }
  return _itemsArray;
}

- (void)cellDidLoad {
  [super cellDidLoad];

  _view = [[UIView alloc] init];
  _view.backgroundColor = [UIColor contentBackgroundColor];
  [self.contentView addSubview:_view];
}

- (void)cellWillAppear {
  _view.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, SCREEN_WIDTH - 20);

  [self addImagesThumbnail];

  // show pictures for 3 * 3 (demo) @TODO: add surplus click delegate.
  // @TODO: deal with only has 2 images, or 4 images to shown like 2 * 1 or 2 * 2
}

- (void)addImagesThumbnail {
  int rowsCount = (int) (ceil(self.item.imageList.count / 3.0));
  NSInteger shownImageCount = self.item.imageList.count;

  if (self.item.imageShownType == LQImageShownTypeAll) {
    // do nothing.
  } else if (self.item.imageShownType == LQImageShownTypeInline) {
    rowsCount = 1;
    shownImageCount = LTE_X(shownImageCount, 3);
  } else {
    rowsCount = LTE_X(rowsCount, 3);
    shownImageCount = LTE_X(shownImageCount, 9);
  }

  //                        Image Width             BorderLayout  header + footer
  // height = rowsCount * ((SCREEN_WIDTH - 28) / 3 +      2) +        16 + 4
  CGFloat height = (CGFloat) (rowsCount * ((SCREEN_WIDTH - 28) / 3.0 + 2) + 18);

  // draw cell frame and setting cell height.
  _view.frame = CGRectMake(10, 10, SCREEN_WIDTH - 20, height);
  self.item.cellHeight = height;

  // show image grid.
  for (NSInteger i = 0; i < self.item.imageList.count; i++) {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
    imageView.tag = i;
    [imageView sd_setImageWithURL:self.item.imageList[(NSUInteger) i] placeholderImage:nil];
    imageView.backgroundColor = [UIColor grayColor];
    CGFloat width = (_view.frame.size.width - 40 + 32) / 3;
    NSInteger row = i / 3;
    NSInteger col = i % 3;
    CGFloat x = 2 + col * (2 + width);
    CGFloat y = 2 + row * (2 + width);
    imageView.frame = CGRectMake(x, y, width, width);

    LQPhotoItems *items = [[LQPhotoItems alloc] init];
    items.url = self.item.imageList[(NSUInteger) i];
    items.sourceView = imageView;
    [self.itemsArray addObject:items];

    // add shown image view.
    if (i < shownImageCount) {
      [_view addSubview:imageView];
    }

    // over flow images. not shown all and has more images to be shown.
    if (self.item.imageShownType != LQImageShownTypeAll && i == shownImageCount - 1
        && shownImageCount < self.item.imageList.count) {
      UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              width,
                                                              width)];
      view.backgroundColor = [UIColor colorWithHexString:@"FFFFFF" andAlpha:0.6];
      [imageView addSubview:view];
      [self.contentView bringSubviewToFront:view];

      UILabel *surplusLabel = [[UILabel alloc] init];

      surplusLabel.text =
          [NSString stringWithFormat:@"+%@", @(self.item.imageList.count - shownImageCount + 1)];
      surplusLabel.font = [UIFont systemFontOfSize:25];
      surplusLabel.textColor = [UIColor whiteColor];

      [view addSubview:surplusLabel];

      [surplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
      }];

      [self.contentView bringSubviewToFront:surplusLabel];
    }
  }
}


- (void)click:(UITapGestureRecognizer *)tap {
  LQPhotoBrowse *photoBrowse = [[LQPhotoBrowse alloc] init];
  photoBrowse.itemsArr = [_itemsArray copy];
  photoBrowse.currentIndex = tap.view.tag;

  [photoBrowse setIsNeedRightTopBtn:NO];
  [photoBrowse setIsNeedPictureLongPress:NO];
  [photoBrowse setIsNeedPageControl:YES];

  [photoBrowse present];
  _photoBrowse = photoBrowse;

  [photoBrowse setDelegate:self];
}

@end