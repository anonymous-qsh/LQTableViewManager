//
// Created by LittleQ on 2019-03-26.
//

#import <Foundation/Foundation.h>
#import "RETableViewItem.h"

@interface LQReadOnlyItem : RETableViewItem

// Data
@property(copy, readwrite, nonatomic) NSString *value;
@property(copy, readwrite, nonatomic) UIColor *titleColor;
@property(copy, readwrite, nonatomic) UIColor *valueColor;
@property(copy, readwrite, nonatomic) UIFont *titleFont;
@property(copy, readwrite, nonatomic) UIFont *valueFont;

// Init functions
+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value;
- (id)initWithTitle:(NSString *)title value:(NSString *)value;

@end
