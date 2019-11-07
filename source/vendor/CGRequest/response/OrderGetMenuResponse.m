//
//  OrderGetMenuResponse.m
//  chijidun
//
//  Created by iMac on 16/9/23.
//
//

#import "OrderGetMenuResponse.h"

@implementation OrderGetMenuResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.list=[ChefTable mj_objectArrayWithKeyValuesArray:response.data[@"list"]];
        
        for (ChefTable *item in self.list) {
            item.list=[ChefItemTable mj_objectArrayWithKeyValuesArray:item.list];
        }
    }
    return self;
}



@end
