//
//  OrderGetTimeIntervalResponse.m
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import "OrderGetTimeIntervalResponse.h"

@implementation OrderGetTimeIntervalResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.name=response.data[@"name"];
        self.hasLeft=response.data[@"hasLeft"];
        self.hasRight=response.data[@"hasRight"];
        self.list=[OrderTimeIntervalTable mj_objectArrayWithKeyValuesArray:response.data[@"list"]];
    }
    return self;
}


@end
