//
//  OrderBackend.h
//  insuny
//
//  Created by txj on 15/5/18.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderAssembler.h"

@interface OrderBackend : Backend
@property (strong, nonatomic) OrderAssembler *assembler;
/**
 *  请求订单列表
 *
 *  @param anUser 用户信息，废弃，可以不传
 *
 *  @return <#return value description#>
 */
- (RACSignal *)requestOrderListWithUser:(USER *)anUser;
/**
 *  请求订单列表
 *
 *  @param filter 过滤器（已收货，未收货....具体请参见接口api）
 *  @param user   用户信息，废弃
 *
 *  @return
 */
- (RACSignal *)requestOrderListWithUser:(FILTER *)filter withUser:(USER *)user;
/**
 *  订单删除
 *
 *  @param order
 *
 *  @return
 */
- (RACSignal *)requestDeleteOrder:(ORDER *)order;

/**
 *  提交订单
 *
 */
- (RACSignal *)requestConfirmOrder:(ORDER *)order;
/**
 *  关闭订单
 *
 */
- (RACSignal *)requestCloseOrder:(ORDER *)order;

@end








