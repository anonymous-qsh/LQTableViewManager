//
// LQTableViewAutoHeightCell.h
//
// Created by LittleQ on 2019-03-26.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RETableViewItem.h"

@interface LQAutoHeightItem : RETableViewItem

@property(nonatomic, strong) NSString *value;

@end

@interface LQTableViewAutoHeightCell : RETableViewCell

@property (nonatomic, strong) LQAutoHeightItem *item;

@end