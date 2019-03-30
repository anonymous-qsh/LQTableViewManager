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

+ (instancetype)itemWithImageList:(NSMutableArray *)imageList imageShownType:(LQImageShownType)imageShownType {
  return [[self alloc] initWithImageList:imageList imageShownType:imageShownType];
}

- (id)initWithImageList:(NSMutableArray *)imageList {
  return [self initWithImageList:imageList imageShownType:LQImageShownTypeMultiline];
}

- (id)initWithImageList:(NSMutableArray *)imageList imageShownType:(LQImageShownType)imageShownType {
  if (self = [super init]) {
    self.imageList = imageList;
    self.imageShownType = imageShownType;
  }
  return self;
}

@end