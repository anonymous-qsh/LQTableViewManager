//
// LQTableViewImageCell.h
//
// Created by LittleQ on 2019-03-28.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RETableViewCell.h"
#import "LQImageItem.h"

@interface LQTableViewImageCell : RETableViewCell  <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(strong, readwrite, nonatomic) LQImageItem *item;

@end