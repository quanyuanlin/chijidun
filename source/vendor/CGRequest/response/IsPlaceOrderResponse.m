//
//  IsPlaceOrderResponse.m
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import "IsPlaceOrderResponse.h"

@implementation IsPlaceOrderResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        
    }
    return self;
}

@end
