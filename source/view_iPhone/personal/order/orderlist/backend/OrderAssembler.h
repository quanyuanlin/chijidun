//
//  OrderAssembler.h
//  insuny
//
//  Created by txj on 15/5/18.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderAssembler : BackendAssembler
/**
 *  订单解析json
 *
 */
-(NSArray *)ordersWithJSON:(NSArray *)JSON;
-(ORDER *)orderWithJSON:(NSDictionary *)JSON;
@end
