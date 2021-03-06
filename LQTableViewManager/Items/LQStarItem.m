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

+ (instancetype)itemWithScore:(double)score :(NSString *)title {
  return [[self alloc] initWithScore:score:title];
}

- (id)initWithScore:(double)score {
  if (self = [super init]) {
    self.score = score;
    self.editable = YES;
    self.isCompleteStar = NO;
    self.numberOfStars = 5;
    self.starWidth = 200;
    self.starHeight = 30;
  }
  return self;
}

- (id)initWithScore:(double)score :(NSString *)title {
    if (self = [super init]) {
        self.score = score;
        self.title = title;
        self.editable = YES;
        self.isCompleteStar = NO;
        self.numberOfStars = 5;
    }
    return self;
}

@end
