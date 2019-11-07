//
//  GetMembersAndOrderResponse.m
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import "GetMembersAndOrderResponse.h"

@implementation GetMembersAndOrderResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.disable=response.data[@"disable"];
        self.timeDisable=response.data[@"timeDisable"];
        self.payType=response.data[@"payType"];
        self.charge=response.data[@"charge"];
        
        self.listCook=[ChefTable mj_objectArrayWithKeyValuesArray:response.data[@"members"][@"cook"]];
        self.listRest=[ChefTable mj_objectArrayWithKeyValuesArray:response.data[@"members"][@"restaurant"]];
        self.order=[TeamOrderTable mj_objectWithKeyValues:response.data[@"order"]];
        
        self.order.lis=[ChefTable mj_objectArrayWithKeyValuesArray:self.order.lis];
        
        for (ChefTable *item in self.order.lis) {
            item.list=[ChefItemTable mj_objectArrayWithKeyValuesArray:item.list];
        }
    
    }
    return self;
}


@end
