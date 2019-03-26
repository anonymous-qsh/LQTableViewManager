//
// Created by LittleQ on 2019-03-26.
//

#import <Foundation/Foundation.h>
#import "RETableViewManager.h"

@interface LQBaseViewController : UIViewController

@property (nonatomic, strong) UITableView *lqTableView;
@property (nonatomic, strong) RETableViewManager *lqManager;


- (void)registerItemClass:(Class)itemClass forCellClass:(Class)cellClass;

@end