//
// Created by LittleQ on 2019-03-26.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "ContentViewController.h"
#import "UIColor+Utils.h"
#import "LQInsetsLabel.h"
#import "LQStar.h"
#import "LQImageItem.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define SAFE_AREA_TOP_HEIGHT (SCREEN_HEIGHT == 812.0 ? 88 : 64)

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"LQBaseViewControllerDemo";

  self.view.backgroundColor = [UIColor clearColor];

  // config table view.
  self.lqTableView.backgroundColor = [UIColor whiteColor];
  [self.lqTableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.bottom.mas_equalTo(0);
    make.top.equalTo(self.view).offset(SAFE_AREA_TOP_HEIGHT);
  }];

  [self addSection];
  [self addAutoHeightSection];
  [self addStarSection];
  [self addImageSection];
}

- (void)addSection {
  RETableViewSection *section = [RETableViewSection section];

  // custom label with insets.
  LQInsetsLabel *headerView = [[LQInsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.f, 24.0f)];
  headerView.textInsets = UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f);

  headerView.backgroundColor = [UIColor separatorLineLightColor];
  headerView.text = @"Table Header";
  headerView.font = [UIFont systemFontOfSize:10];

  section.headerView = headerView;
  section.headerHeight = 30;

  for (int i = 0; i < 2; ++i) {
    [section addItem:[[LQReadOnlyItem alloc] initWithTitle:[NSString stringWithFormat:@"Title--%d", i] value:[NSString stringWithFormat:@"Value--%d", i]]];
  }

  // change color and font read only item.
  LQReadOnlyItem *item = [[LQReadOnlyItem alloc] initWithTitle:@"change font" value:@"change color"];
  item.titleFont = [UIFont systemFontOfSize:10];
  item.valueColor = [UIColor mainColor];

  [section addItem:item];

  [self.lqManager addSection:section];
  [self.lqTableView reloadData];
}

- (void)addAutoHeightSection {
  RETableViewSection *section = [RETableViewSection section];

  LQAutoHeightItem *item = [[LQAutoHeightItem alloc] init];
  item.value =
      @"This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text. This is a long text.";

  [section addItem:item];

  [self.lqManager addSection:section];
  [self.lqTableView reloadData];
}

- (void)addStarSection {
  RETableViewSection *section = [RETableViewSection section];

  LQStarItem *item = [[LQStarItem alloc] initWithScore:0.6];
  item.isCompleteStar = YES;
  item.numberOfStars = 5;
  item.editable = NO;

  [section addItem:item];

  LQStarItem *inlineItem = [[LQStarItem alloc] initWithScore:0.6 :@"Title"];
  [section addItem:inlineItem];

  [self.lqManager addSection:section];
  [self.lqTableView reloadData];
}

- (void)addImageSection {
  RETableViewSection *section = [RETableViewSection section];

  NSArray *urlArr = @[
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
      @"https://cdn.pixabay.com/photo/2016/03/26/13/09/cup-of-coffee-1280537_960_720.jpg",
  ];

  [section addItem:[[LQReadOnlyItem alloc] initWithTitle:@"Shown image inline"]];

  LQImageReadOnlyItem
      *item =
      [[LQImageReadOnlyItem alloc] initWithImageList:[urlArr mutableCopy] imageShownType:LQImageShownTypeInline];

  [section addItem:item];

  [section addItem:[[LQReadOnlyItem alloc] initWithTitle:@"Shown image multi line (max <= 9)"]];

  [section addItem:[[LQImageReadOnlyItem alloc] initWithImageList:[urlArr mutableCopy] imageShownType:LQImageShownTypeMultiline]];

  [section addItem:[[LQReadOnlyItem alloc] initWithTitle:@"Shown image all"]];

  [section addItem:[[LQImageReadOnlyItem alloc] initWithImageList:[urlArr mutableCopy] imageShownType:LQImageShownTypeAll]];

  [self.lqManager addSection:section];
  [self.lqTableView reloadData];
}

@end
