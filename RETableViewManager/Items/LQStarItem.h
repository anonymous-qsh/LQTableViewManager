//
// LQStarItem.h
//
// Created by LittleQ on 2019-03-27.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RETableViewItem.h"

@interface LQStarItem : RETableViewItem

// data
@property(readwrite, assign) double score; // 0 -> 1
@property(readwrite, nonatomic) BOOL editable;
@property(readwrite, nonatomic) NSInteger numberOfStars;
@property(readwrite, nonatomic) BOOL isCompleteStar; // could half star.

+ (instancetype)itemWithScore:(double)score;
- (id)initWithScore:(double)score;

@end