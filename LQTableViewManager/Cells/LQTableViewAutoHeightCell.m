//
// LQTableViewAutoHeightCell.m
//
// Created by LittleQ on 2019-03-26.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "LQTableViewAutoHeightCell.h"

@interface LQAutoHeightItem ()

@end

@implementation LQAutoHeightItem

- (id)init {
  if (self = [super init]) {
  };
  return self;
}

+ (instancetype)itemWitValue:(NSString *)value {
  return [[self init] initWithValue:value];
}

- (id)initWithValue:(NSString *)value {
  if (self = [self init]) {
    self.value = value;
    self.valueFont = [UIFont systemFontOfSize:15];
    self.valueColor = [UIColor blackColor];
  }
  return self;
}

@end

@interface LQTableViewAutoHeightCell ()

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel *valueLabel;

@end

@implementation LQTableViewAutoHeightCell

@dynamic item;

- (void)cellDidLoad {
  [super cellDidLoad];

  _bgView = [[UIView alloc] init];
  _bgView.layer.cornerRadius = 5;
  [self.contentView addSubview:_bgView];

  [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView).inset(10);
  }];

  _valueLabel = [[UILabel alloc] init];
  _valueLabel.numberOfLines = 0;
  _valueLabel.backgroundColor = [UIColor clearColor];
//  _valueLabel.font = [UIFont systemFontOfSize:15];
//  _valueLabel.textColor = [UIColor blackColor];
  // not show ... for overflow text.
  _valueLabel.numberOfLines = 0;
  [self.bgView addSubview:_valueLabel];

  [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.bgView).inset(5);
  }];

}

- (void)cellWillAppear {
  [super cellWillAppear];

  self.valueLabel.font = self.item.valueFont;
  self.valueLabel.textColor = self.item.valueColor;
  self.valueLabel.text = self.item.value;
}

@end
