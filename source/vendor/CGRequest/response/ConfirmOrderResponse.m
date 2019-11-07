//
//  ConfirmOrderResponse.m
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import "ConfirmOrderResponse.h"

@implementation ConfirmOrderResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {        
        NSArray *array=response.data[@"list"];
        NSMutableArray *arrayChefs=[NSMutableArray array];
        for (int i=0; i<array.count; i++) {
            ChefTable *chef=[[ChefTable alloc]init];
            chef.list=[ChefItemTable mj_objectArrayWithKeyValuesArray:array[i]];
            [arrayChefs addObject:chef];
        }
        
        NSMutableArray *items=[NSMutableArray array];
        for (ChefTable *chef in arrayChefs) {
            for (int i=0; i<chef.list.count; i++) {
                ChefItemTable *item=chef.list[i];
                if (i>0) {
                    item.mname=@"";
                }
                [items addObject:item];
            }
        }
        self.list=[NSArray arrayWithArray:items];

        
        self.address=[TeamAddressTable mj_objectArrayWithKeyValuesArray:response.data[@"address"]];
        
        self.total=response.data[@"total"];
        self.companyPay=response.data[@"companyPay"];
        self.userPay=response.data[@"userPay"];
        self.mealTime=response.data[@"mealTime"];
        self.category=response.data[@"category"];
        self.payType=response.data[@"payType"];
    }
    return self;
}


@end
