//
//  OrderAddResponse.m
//  chijidun
//
//  Created by iMac on 16/10/31.
//
//

#import "OrderAddResponse.h"

@implementation OrderAddResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.order=[OrderTable mj_objectWithKeyValues:response.data];
    }
    return self;
}


@end
