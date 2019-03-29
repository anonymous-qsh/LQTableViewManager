//
// LQPhotoBrowseNumView.m
//
// Created by LittleQ on 2019-03-29.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "LQPhotoBrowseNumView.h"

@implementation LQPhotoBrowseNumView

- (instancetype)init{
  if (self = [super init]) {
    [self setFont:[UIFont boldSystemFontOfSize:20]];
    [self setTextColor:[UIColor whiteColor]];
    [self setTextAlignment:NSTextAlignmentCenter];
  }
  return self;
}

- (void)setCurrentNum:(NSInteger)currentNum totalNum:(NSInteger)totalNum{
  _currentNum = currentNum;
  _totalNum = totalNum;
  [self changeText];
}

- (void)changeText{
  self.text = [NSString stringWithFormat:@"%zd / %zd",_currentNum,_totalNum];
}

- (void)setCurrentNum:(NSInteger)currentNum{
  _currentNum = currentNum;
  [self changeText];
}

- (void)setTotalNum:(NSInteger)totalNum{
  _totalNum = totalNum;
  [self changeText];
}

@end