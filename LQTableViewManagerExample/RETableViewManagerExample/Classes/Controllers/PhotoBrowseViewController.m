//
// PhotoBrowseViewController.m
//
// Created by LittleQ on 2019-03-29.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "PhotoBrowseViewController.h"
#import "UIImageView+WebCache.h"
#import "LQPhotoBrowse.h"
#import "MBProgressHUD.h"
#import "LQPhotoBrowseImageView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SAFE_AREA_TOP_HEIGHT (SCREEN_HEIGHT == 812.0 ? 88 : 64)

@interface PhotoBrowseViewController() <LQPhotoBrowseDelegate, MBProgressHUDDelegate> {
  BOOL _ApplicationStatusIsHidden;
}

@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (nonatomic, strong) LQPhotoBrowse *photoBrowse;

@end


@implementation PhotoBrowseViewController

- (NSMutableArray *)itemsArray{
  if (!_itemsArray) {
    _itemsArray = [NSMutableArray array];
  }
  return _itemsArray;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"PhotoBrowseVCDemo";

//  self.view.backgroundColor = [UIColor clearColor];

//  // config table view.
//  self.lqTableView.backgroundColor = [UIColor whiteColor];
//  [self.lqTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.left.right.bottom.mas_equalTo(0);
//    make.top.equalTo(self.view).offset(SAFE_AREA_TOP_HEIGHT);
//  }];

  self.automaticallyAdjustsScrollViewInsets = NO;
  
  // clear cache for test, in product env you do not need this.
  [[SDWebImageManager sharedManager].imageCache clearMemory];
  
  NSArray *urlArr = @[
                      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
                      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
                      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
                      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
                      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
                      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
                      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
                      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
                      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg"
                      ];
  
  CGFloat viewWidth = self.view.frame.size.width;
  
  // background view
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 100, viewWidth - 20, viewWidth - 20)];
  view.backgroundColor = [UIColor grayColor];
  [self.view addSubview:view];

  // show pictures for 3 * 3 (demo)
  for (NSInteger i = 0 ;i < urlArr.count; i ++) {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
    imageView.tag = i;
    [imageView sd_setImageWithURL:urlArr[i] placeholderImage:nil];
    imageView.backgroundColor = [UIColor grayColor];
    CGFloat width = (view.frame.size.width - 40) / 3;
    NSInteger row = i / 3;
    NSInteger col = i % 3;
    CGFloat x = 10 + col * (10 + width);
    CGFloat y = 10 + row * (10 + width);
    imageView.frame = CGRectMake(x, y, width, width);

    LQPhotoItems *items = [[LQPhotoItems alloc] init];
    items.url = urlArr[i];
    items.sourceView = imageView;
    [self.itemsArray addObject:items];

    [view addSubview:imageView];
  }

}

#pragma mark 实现
- (void)click:(UITapGestureRecognizer *)tap{
  LQPhotoBrowse *photoBrowse = [[LQPhotoBrowse alloc] init];
  photoBrowse.itemsArr = [_itemsArray copy];
  photoBrowse.currentIndex = tap.view.tag;

  [photoBrowse setIsNeedRightTopBtn:YES]; // 是否需要 右上角 操作功能按钮
  [photoBrowse setIsNeedPictureLongPress:NO]; // 是否 需要 长按图片 弹出框功能 .默认:需要
  [photoBrowse setIsNeedPageControl:YES];  // 是否需要 底部 UIPageControl, Default is NO

  [photoBrowse present];
  _photoBrowse = photoBrowse;

  // 设置代理方法 --->可不写
  [photoBrowse setDelegate:self];

  // 这里是 设置 状态栏的 隐藏 ---> 可不写
  _ApplicationStatusIsHidden = YES;
  [self setNeedsStatusBarAppearanceUpdate];
}

@end
