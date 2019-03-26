//
// Created by LittleQ on 2019-03-26.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "LQInsetsLabel.h"

@implementation LQInsetsLabel

- (instancetype)init {
  if (self = [super init]) {
    _textInsets = UIEdgeInsetsZero;
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    _textInsets = UIEdgeInsetsZero;
  }
  return self;
}

- (void)drawTextInRect:(CGRect)rect {
  [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

@end