//
// LQStarItem.m
//
// Created by LittleQ on 2019-03-27.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "LQStarItem.h"

@implementation LQStarItem

+ (instancetype)itemWithScore:(double)score {
  return [[self alloc] initWithScore:score];
}

- (id)initWithScore:(double)score {
  if (self = [super init]) {
    self.score = score;
    self.editable = YES;
    self.isCompleteStar = NO;
    self.numberOfStars = 5;
  };
  return self;
}

@end