//
// LQTableViewStarCell.m
//
// Created by LittleQ on 2019-03-27.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "LQTableViewStarCell.h"
#import "LQStarItem.h"
#import "LQStar.h"

@interface LQTableViewStarCell ()

@property(nonatomic, strong) LQStar *star;

@end

@implementation LQTableViewStarCell

@synthesize item = _item;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Woverriding-method-mismatch"
+ (BOOL)canFocusWithItem:(LQStarItem *)item {
  return item.editable;
}
#pragma clang diagnostic pop

- (void)dealloc {
  if (_item != nil) {
    [_item removeObserver:self forKeyPath:@"enabled"];
  }
}

// @TODO: can not resolve the problem to load image. -- by Lq @(2019-03-27)
- (void)cellWillAppear {
  [super cellWillAppear];

  _star = [[LQStar alloc] initWithFrame:CGRectMake(10, 5, 200, 30) numberOfStars:self.item.numberOfStars];
  _star.scorePercent = (CGFloat) self.item.score;
  _star.isCompleteStar = self.item.isCompleteStar;
  _star.isAnimation = YES;
  _star.isJustDisplay = !self.item.editable;

  _star.sendStarPercent = ^(double data) {
    self.item.score = data;
  };

  [self.contentView addSubview:_star];

}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Woverriding-method-mismatch"
- (void)setItem:(LQStarItem *)item {
  if (_item != nil) {
    [_item removeObserver:self forKeyPath:@"enabled"];
  }

  _item = item;

  [_item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
}
#pragma clang diagnostic pop

@end