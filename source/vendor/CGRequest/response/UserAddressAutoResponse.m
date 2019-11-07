//
//  UserAddressAutoResponse.m
//  chijidun
//
//  Created by iMac on 16/11/17.
//
//

#import "UserAddressAutoResponse.h"

@implementation UserAddressAutoResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.address=[UserAddressTable mj_objectWithKeyValues:response.data];
    }
    return self;
}




@end
