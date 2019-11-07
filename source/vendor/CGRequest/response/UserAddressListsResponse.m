//
//  UserAddressListsResponse.m
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import "UserAddressListsResponse.h"

@implementation UserAddressListsResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.list=[UserAddressTable mj_objectArrayWithKeyValuesArray:response.data[@"list"]];
    }
    return self;
}


@end
