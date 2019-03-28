//
// Created by LittleQ on 2019-03-26.
//

#import "LQReadOnlyItem.h"

@implementation LQReadOnlyItem

+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value {
  return [[self alloc] initWithTitle:title value:value];
}

- (id)initWithTitle:(NSString *)title value:(NSString *)value {
  self = [super init];
  if (!self)
    return nil;

  self.title = title;
  self.value = value;
  
  self.titleColor = [UIColor blackColor];
  self.valueColor = [UIColor blackColor];
  
  self.titleFont = [UIFont systemFontOfSize:14];
  self.valueFont = [UIFont systemFontOfSize:14];

  return self;
}

@end
