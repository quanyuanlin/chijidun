//
//  TeamOrderListView.h
//  chijidun
//
//  Created by iMac on 16/9/21.
//
//

#import <UIKit/UIKit.h>
#import "TeamOrderListCell.h"
#import "TeamOrderDetailVC.h"
#import "TeamOrderListVC.h"

@interface TeamOrderListView : UIView
<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *lists;

-(void)reloadDatasWith:(BOOL)isFirst;
@property (nonatomic,strong) void(^refreshBlock)();

@end
