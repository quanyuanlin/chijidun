//
//  OrderStatusTableViewCell.h
//  insuny
//
//  Created by iMac on 15/8/21.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderStatusTableViewCell : UITableViewCell

@property (strong, nonatomic) ORDER *order;
-(void)setOrderStatus;


@end
