//
//  OrderConfirmOrderResponse.m
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import "OrderConfirmOrderResponse.h"

@implementation OrderConfirmOrderResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.quan=[QuanTable mj_objectWithKeyValues:response.data[@"coupon"]];
        self.member=[MemberTable mj_objectWithKeyValues:response.data[@"member"]];
        self.time_list=response.data[@"time_list"];        
        self.remark_list=[RemarkTable mj_objectArrayWithKeyValuesArray:response.data[@"remark_list"]];
    }
    return self;
}

@end
