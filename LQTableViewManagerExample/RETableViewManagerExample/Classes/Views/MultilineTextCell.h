//
//  MultilineTextCell.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 9/11/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <LQTableViewManager/RETableViewManager.h>
#import "MultilineTextItem.h"

@interface MultilineTextCell : RETableViewCell

@property (strong, readwrite, nonatomic) MultilineTextItem *textItem;
@property (strong, readonly, nonatomic) UILabel *multilineLabel;

@end
