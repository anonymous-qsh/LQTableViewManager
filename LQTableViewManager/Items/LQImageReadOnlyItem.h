//
// LQImageReadOnlyItem.h
//
// Created by LittleQ on 2019-03-29.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RETableViewItem.h"

@interface LQImageReadOnlyItem : RETableViewItem

// data
@property (nonatomic, strong, readwrite) NSMutableArray *imageList;

+ (instancetype)itemWithImageList: (NSMutableArray *) imageList;
- (id)initWithImageList: (NSMutableArray *) imageList;

@end