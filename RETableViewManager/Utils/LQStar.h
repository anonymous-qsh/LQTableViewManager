//
// LQStar.h
//
// Created by LittleQ on 2019-03-27.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LQStar : UIView

@property(nonatomic,assign) CGFloat scorePercent;
@property(nonatomic,assign) BOOL isAnimation;
@property(nonatomic,assign) BOOL isCompleteStar;
@property(nonatomic,assign) BOOL isJustDisplay;


- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;

@property(nonatomic,strong) void (^sendStarPercent)(double percent);

@end