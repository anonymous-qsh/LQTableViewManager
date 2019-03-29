//
// LQPhotoBrowseCell.h
//
// Created by LittleQ on 2019-03-29.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SingleTap)();
typedef void(^LongPress)();

@interface LQPhotoBrowseCell : UICollectionViewCell

- (void)sd_ImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder;

@property (nonatomic, copy  ) SingleTap singleTap;
@property (nonatomic, copy  ) LongPress longPress;

@end