//
// LQTableViewStarCell.h
//
// Created by LittleQ on 2019-03-27.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RETableViewCell.h"
#import "LQStarItem.h"

@interface LQTableViewStarCell : RETableViewCell

@property(strong, readwrite, nonatomic) LQStarItem *item;

@end