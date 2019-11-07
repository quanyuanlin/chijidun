//
//  OrderBackend.m
//  insuny
//
//  Created by txj on 15/5/18.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "OrderBackend.h"

@implementation OrderBackend
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.assembler=[OrderAssembler new];
    }
    return self;
}
- (RACSignal *)requestOrderListWithUser:(FILTER *)filter withUser:(USER *)user
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    if (filter.pagenation.page> [NSNumber numberWithInt:0])
    {
        data= [self.assembler paginationToJsonObject:filter.pagenation];
    }
    if (filter.status) {
        //未完成
        if ([toNSString(filter.status) isEqualToString:@"1"]) {
            [data setValue:@"0,1,2,3" forKey:@"status"];
        }
        //已完成
        if ([toNSString(filter.status) isEqualToString:@"2"]) {
            [data setValue:@"5,6,7" forKey:@"status"];
        }
        //待评价
        if ([toNSString(filter.status) isEqualToString:@"3"]) {
            [data setValue:@"4" forKey:@"status"];
        }
        //退款
        if ([toNSString(filter.status) isEqualToString:@"4"]) {
            [data setValue:@"8,10" forKey:@"status"];
        }
    }
    
    NSError *error;
    NSData *dumps = [NSJSONSerialization dataWithJSONObject:data options:0
                                                      error:&error];
    NSString *requestJSON;
    requestJSON = [[NSString alloc] initWithData:dumps
                                        encoding:NSUTF8StringEncoding];
    parameters[@"data"] = requestJSON;
    
    
    @weakify(self)
    return
    [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        [self
         POST:[NSString stringWithFormat:@"%@/order/lists",
               self.config.backendURL]
         parameters:parameters
         success:^(AFHTTPRequestOperation *operation,
                   id responseObject) {
             
             NSInteger status=[[responseObject objectForKey:@"status"] integerValue];
             if(status)
             {
                 NSMutableDictionary *data=[responseObject objectForKey:@"data"];
                 filter.pagenation= [self.assembler pagination:data[@"pageInfo"]];
                 [subscriber sendNext:RACTuplePack(filter,
                                                   [self.assembler ordersWithJSON:[[responseObject objectForKey:@"data"] objectForKey:@"list"]])];
             }
             else{
                 
                 [subscriber sendNext:RACTuplePack(filter,
                                                   [self.assembler ordersWithJSON:nil])];
             }
             
             
         } failure:^(AFHTTPRequestOperation *operation,
                     NSError *error) {
             [subscriber sendError:error];
         }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
}

- (RACSignal *)requestConfirmOrder:(ORDER *)order 
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[NSString stringWithFormat:@"{\"id\":%d}", [order.rec_id intValue]]
                   forKey:@"data"];
    @weakify(self)
    return
    [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        [self
         POST:[NSString stringWithFormat:@"%@/order/orderConfirm",
               self.config.backendURL]
         parameters:parameters
         success:^(AFHTTPRequestOperation *operation,
                   id responseObject) {
             [subscriber sendNext:
              [self.assembler responseResult:responseObject]];
         } failure:^(AFHTTPRequestOperation *operation,
                     NSError *error) {
             [subscriber sendError:error];
         }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
}
-(RACSignal *)requestCloseOrder:(ORDER *)order
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:[NSString stringWithFormat:@"{\"id\":%d}", [order.rec_id intValue]]
                   forKey:@"data"];
    @weakify(self)
    return
    [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        [self
         POST:[NSString stringWithFormat:@"%@/order/orderClose",
               self.config.backendURL]
         parameters:parameters
         success:^(AFHTTPRequestOperation *operation,
                   id responseObject) {
             [subscriber sendNext:
              [self.assembler responseResult:responseObject]];
         } failure:^(AFHTTPRequestOperation *operation,
                     NSError *error) {
             [subscriber sendError:error];
         }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
}

@end








