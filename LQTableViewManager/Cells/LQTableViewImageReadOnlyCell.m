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

  _view = [[UIView alloc] initWithFrame:CGRectMake(10,
                                                   10,
                                                   SCREEN_WIDTH - 20,
                                                   SCREEN_WIDTH - 20)];
  _view.backgroundColor = [UIColor contentBackgroundColor];
  [self.contentView addSubview:_view];
}

- (void)cellWillAppear {
  // show pictures for 3 * 3 (demo) @TODO: 添加图片罩层 最后一个显示加 n, 添加最后一个点击的委托
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

    if (i == 8) {
      UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              width,
                                                              width)];
      view.backgroundColor = [UIColor colorWithHexString:@"FFFFFF" andAlpha:0.6];
      [imageView addSubview:view];
      [self.contentView bringSubviewToFront:view];

      UILabel *surplusLabel = [[UILabel alloc] init];

      surplusLabel.text = @"+15";
      surplusLabel.font = [UIFont systemFontOfSize:25];
      surplusLabel.textColor = [UIColor whiteColor];

      [view addSubview:surplusLabel];

      [surplusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
      }];

      [self.contentView bringSubviewToFront:surplusLabel];
    }

    LQPhotoItems *items = [[LQPhotoItems alloc] init];
    items.url = self.item.imageList[(NSUInteger) i];
    items.sourceView = imageView;
    [self.itemsArray addObject:items];

    [_view addSubview:imageView];
  }
}

- (void)addSurplusView {
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