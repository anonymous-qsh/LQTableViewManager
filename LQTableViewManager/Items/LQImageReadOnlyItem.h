//
// LQImageReadOnlyItem.h
//
// Created by LittleQ on 2019-03-29.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "RETableViewItem.h"

typedef NS_ENUM(NSUInteger, LQImageShownType) {
  LQImageShownTypeAll, // show all photos. 1 * 2 | 2 * 2 | 3 * n
  LQImageShownTypeInline, // show photos only for one line. 1 * 2 | 1 * 3
  LQImageShownTypeMultiline // show photos for multi line. 3 * 3(max)
};

@interface LQImageReadOnlyItem : RETableViewItem

// data
@property(nonatomic, strong, readwrite) NSMutableArray *imageList;

@property(nonatomic, readwrite, assign) LQImageShownType imageShownType;

+ (instancetype)itemWithImageList:(NSMutableArray *)imageList;
+ (instancetype)itemWithImageList:(NSMutableArray *)imageList imageShownType:(LQImageShownType)imageShownType;

- (id)initWithImageList:(NSMutableArray *)imageList;
- (id)initWithImageList:(NSMutableArray *)imageList imageShownType:(LQImageShownType)imageShownType;

@end