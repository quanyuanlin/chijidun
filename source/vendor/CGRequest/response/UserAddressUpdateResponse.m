//
//  UserAddressUpdateResponse.m
//  chijidun
//
//  Created by iMac on 16/11/17.
//
//

#import "UserAddressUpdateResponse.h"

@implementation UserAddressUpdateResponse

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
