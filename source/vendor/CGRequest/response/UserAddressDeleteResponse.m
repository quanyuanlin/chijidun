//
//  UserAddressDeleteResponse.m
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import "UserAddressDeleteResponse.h"

@implementation UserAddressDeleteResponse

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
