//
// LQImageItem.m
//
// Created by LittleQ on 2019-03-28.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "LQImageItem.h"

@implementation LQImageItem

+ (instancetype)itemWithTarget:(nullable id)target {
  return [[self alloc] initWithTarget:target];
}
- (id)initWithTarget:(nullable id)target {
  if (self = [super init]) {
    self.vc = target;
  }
  return self;
}

@end