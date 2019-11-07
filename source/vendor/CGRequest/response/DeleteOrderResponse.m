//
//  DeleteOrderResponse.m
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import "DeleteOrderResponse.h"

@implementation DeleteOrderResponse

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
