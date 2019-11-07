//
//  OrderPayListResponse.m
//  chijidun
//
//  Created by iMac on 16/11/18.
//
//

#import "OrderPayListResponse.h"

@implementation OrderPayListResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.payList=response.data[@"list"];
    }
    return self;
}


@end
