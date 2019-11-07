//
//  OrderDetailViewController.h
//  insuny
//
//  Created by txj on 15/5/18.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "OrderListTableViewCell.h"
#import "OrderStatusTableViewCell.h"
#import "OrderDetailTableViewCellHeader.h"
#import "OrderDetailTableViewCellFooter.h"
#import "OrderButtomBarTableViewCellFooter.h"
#import "OrderDetailSection4TableViewCell.h"
#import "AddressTableViewCell.h"
#import "OrderListTableViewCellFooter.h"
#import "OrderBackend.h"
#import "PaymentViewController.h"
#import "CommentViewController.h"
#import "OrderDetailViewCellFooter2.h"
#import "OrderListViewController.h"

@interface OrderDetailViewController : TBaseUIViewController<UITableViewDataSource,UITableViewDelegate,OrderListTableViewCellFooterDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) OrderBackend *backend;

@property (strong, nonatomic) ORDER* order;

- (instancetype)initWithOrderId:(NSString *)orderid;
- (instancetype)initWithOrderId:(NSString *)orderid With:(BOOL)isPayVC;
@property (strong,nonatomic) void(^refundBlock)();

@end


