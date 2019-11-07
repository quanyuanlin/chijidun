//
//  GetOrderInfoResponse.m
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import "GetOrderInfoResponse.h"

@implementation GetOrderInfoResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.order=[TeamOrderTable mj_objectWithKeyValues:response.data];
        
        NSMutableArray *arrayChefs=[NSMutableArray array];
        for (int i=0; i<self.order.list.count; i++) {
            ChefTable *chef=[[ChefTable alloc]init];
            chef.list=[ChefItemTable mj_objectArrayWithKeyValuesArray:self.order.list[i]];
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
        self.items=[NSArray arrayWithArray:items];
    }
    return self;
}


@end
