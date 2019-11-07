//
//  UserAddressAddResponse.m
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import "UserAddressAddResponse.h"

@implementation UserAddressAddResponse

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
