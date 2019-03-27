//
// Created by LittleQ on 2019-03-26.
//

#import "LQTableViewReadOnlyCell.h"
#import "LQReadOnlyItem.h"

@interface LQTableViewReadOnlyCell()

@end

@implementation LQTableViewReadOnlyCell

@synthesize item = _item;

- (void)cellDidLoad {
  [super cellDidLoad];

  self.valueLabel = [[UILabel alloc] init];
  [self.contentView addSubview: self.valueLabel];
}

- (void)cellWillAppear {
  [super cellWillAppear];
  self.selectionStyle = UITableViewCellSelectionStyleNone;

  self.valueLabel.text = self.item.value;
  [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    // this value of 12 due to textLabel -- by Lq.
    make.bottom.equalTo(self.textLabel).offset(-12);
    make.right.equalTo(self).offset(-10);
  }];
}

@end