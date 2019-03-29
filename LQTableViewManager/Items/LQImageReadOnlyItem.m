//
// LQImageReadOnlyItem.m
//
// Created by LittleQ on 2019-03-29.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "LQImageReadOnlyItem.h"

@implementation LQImageReadOnlyItem

+ (instancetype)itemWithImageList:(NSMutableArray *)imageList {
  return [[self alloc] initWithImageList:imageList];
}

- (id)initWithImageList:(NSMutableArray *)imageList {
  if (self = [super init]) {
    self.imageList = imageList;
  }
  return self;
}

@end