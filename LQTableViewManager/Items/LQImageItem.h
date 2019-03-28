//
// LQImageItem.h
//
// Created by LittleQ on 2019-03-28.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RETableViewItem.h"

@interface LQImageItem : RETableViewItem

// data
@property(nonatomic, readwrite, strong) NSMutableArray *imageList;
@property(nonatomic, assign) int maxImageCount;
@property(nonatomic, strong) UIViewController *vc;

+ (instancetype)itemWithTarget: (nullable id) target;
- (id)initWithTarget: (nullable id) target;

@end