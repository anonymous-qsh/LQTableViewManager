//
// LQPhotoBrowseNumView.h
//
// Created by LittleQ on 2019-03-29.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQPhotoBrowseNumView : UILabel

- (void)setCurrentNum:(NSInteger)currentNum totalNum:(NSInteger)totalNum;

@property (nonatomic, assign) NSInteger currentNum;
@property (nonatomic, assign) NSInteger totalNum;

@end