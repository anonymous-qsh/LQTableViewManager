//
// Created by LittleQ on 2019-03-26.
//

#import <Foundation/Foundation.h>
#import "RETableViewCell.h"
#import "LQReadOnlyItem.h"

@interface LQTableViewReadOnlyCell : RETableViewCell

@property (strong, readwrite, nonatomic) LQReadOnlyItem *item;
@property(strong, readwrite, nonatomic) UILabel *valueLabel;

@end