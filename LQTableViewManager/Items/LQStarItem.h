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

@property(readwrite, nonatomic) CGFloat starHeight;
@property(readwrite, nonatomic) CGFloat starWidth;

+ (instancetype)itemWithScore:(double)score;
- (id)initWithScore:(double)score;

+ (instancetype)itemWithScore:(double)score :(NSString *)title;
- (id)initWithScore:(double)score :(NSString *)title;

@end
