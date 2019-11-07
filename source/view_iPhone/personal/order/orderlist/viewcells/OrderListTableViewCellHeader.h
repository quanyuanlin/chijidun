//
//  CartTableViewCellHeader.h
//  insuny
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  cell模板，各属性请对照.xib文件
 */
@class OrderListTableViewCellHeader;
@protocol OrderListTableViewCellHeaderDelegate <NSObject>

- (void)ClickOrderListTableViewCellHeader:(ORDER *)anOrder;

@end
@interface OrderListTableViewCellHeader : TUITableViewHeaderFooterView
@property (nonatomic, strong) id<OrderListTableViewCellHeaderDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) ORDER *order;
@end
