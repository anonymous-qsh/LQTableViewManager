//
// Created by LittleQ on 2019-03-26.
//

#import "LQBaseViewController.h"

@interface LQBaseViewController () <RETableViewManagerDelegate>

@end

@implementation LQBaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self.view addSubview:self.lqTableView];
  self.lqManager.style.cellHeight = UITableViewAutomaticDimension; // setting to auto calc cell height.

  if (@available(iOS 11.0, *)) {
    self.lqTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  } else {
    self.automaticallyAdjustsScrollViewInsets = NO;
  }

}

- (UITableView *)lqTableView {
  if (_lqTableView) {
    return _lqTableView;
  }

  _lqTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  _lqTableView.tableHeaderView = [[UIView alloc] init];
  _lqTableView.tableFooterView = [[UIView alloc] init];
  _lqTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

  return _lqTableView;
}

- (RETableViewManager *)lqManager {
  if (_lqManager) {
    return _lqManager;
  }

  _lqManager = [[RETableViewManager alloc] initWithTableView:self.lqTableView];
  _lqManager.delegate = self;

  return _lqManager;
}

- (void)registerItemClass:(Class)itemClass forCellClass:(Class)cellClass {
  [self.lqManager registerClass:NSStringFromClass(itemClass) forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

#pragma mark - DelegateForRETableViewManager

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex {
  return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView willLayoutCellSubviews:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView willLoadCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView didLoadCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end