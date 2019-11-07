//
//  AccountOrderResponse.m
//  chijidun
//
//  Created by iMac on 16/10/14.
//
//

#import "AccountOrderResponse.h"

@implementation AccountOrderResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.orderList=[TeamOrderTable mj_objectArrayWithKeyValuesArray:response.data[@"orderList"]];
    
        self.mealType=response.data[@"mealType"];
        self.isLast=[response.data[@"isLast"] intValue];
    }
    return self;
}

@end
