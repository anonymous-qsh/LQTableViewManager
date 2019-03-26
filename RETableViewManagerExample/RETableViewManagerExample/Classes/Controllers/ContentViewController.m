//
// Created by LittleQ on 2019-03-26.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "ContentViewController.h"
#import "UIColor+Utils.h"
#import "LQInsetsLabel.h"

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
}

- (void)addSection {
  RETableViewSection *section = [RETableViewSection section];

  // custom label with insets.
  LQInsetsLabel *headerView = [[LQInsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.f, 24.0f)];
  headerView.textInsets = UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f);

  headerView.backgroundColor = [UIColor separatorColor];
  headerView.text = @"Table Header";
  headerView.font = [UIFont systemFontOfSize:10];

  section.headerView = headerView;
  section.headerHeight = 30;

  for (int i = 0; i < 30; ++i) {
    [section addItem:[[LQReadOnlyItem alloc] initWithTitle:[NSString stringWithFormat:@"Title--%d", i] value:[NSString stringWithFormat:@"Value--%d", i]]];
  }

  [self.lqManager addSection:section];
  [self.lqTableView reloadData];
}

@end