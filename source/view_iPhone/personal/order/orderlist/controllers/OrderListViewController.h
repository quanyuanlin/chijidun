//
//  OrderViewController.h
//  insuny
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "OrderDetailViewController.h"

#import "OrderBackend.h"
#import <XZFramework/ThreeStageSegmentView.h>
#import "OrderListTableViewCell.h"
#import "OrderListTableViewCellHeader.h"
#import "OrderListTableViewCellFooter.h"
#import "PaymentViewController.h"
#import "CommentViewController.h"
#import "CommentDetailVC.h"
#import "ChefDetailVC.h"
#import "MyCommentsViewController.h"

/**
 *  订单列表
 */
@interface OrderListViewController : TBaseUIViewController<UITableViewDataSource,UITableViewDelegate,ThreeStageSegmentViewDelegate,OrderListTableViewCellFooterDelegate,OrderListTableViewCellHeaderDelegate>

@property (weak, nonatomic) IBOutlet UIView *threeSegmentBtn;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray* datalist;
@property (strong, nonatomic) OrderBackend *backend;
@property (strong, nonatomic) FILTER *filter;
@property (nonatomic, weak) USER *user;

@property BOOL isFromPay;
-(instancetype)initWithOrderStatus:(NSInteger)status;

@property int backType;
//0.普通返回
//1.确认订单成功查看订单 2.确认订单成功返回列表 3.确认订单失败返回
//4.订单列表付款成功查看订单 5.订单列表付款成功返回列表 6.订单列表付款失败返回
//7.订单详情付款成功查看订单 8.订单详情成功返回列表 9.订单详情失败返回

@end







