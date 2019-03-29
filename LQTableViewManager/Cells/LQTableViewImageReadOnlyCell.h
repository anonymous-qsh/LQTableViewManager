//
// LQTableViewImageReadOnlyCell.h
//
// Created by LittleQ on 2019-03-29.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RETableViewCell.h"
#import "LQImageReadOnlyItem.h"

@interface LQTableViewImageReadOnlyCell : RETableViewCell

@property(nonatomic, strong) LQImageReadOnlyItem *item;

@end