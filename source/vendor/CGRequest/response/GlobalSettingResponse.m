//
//  GlobalSettingResponse.m
//  chijidun
//
//  Created by iMac on 16/10/28.
//
//

#import "GlobalSettingResponse.h"

@implementation GlobalSettingResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.default_freight=response.data[@"default_freight"];
        self.free_shipping_money=response.data[@"free_shipping_money"];
    }
    return self;
}

@end
