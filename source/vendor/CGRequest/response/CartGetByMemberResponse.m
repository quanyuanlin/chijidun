//
//  CartGetByMemberResponse.m
//  chijidun
//
//  Created by iMac on 16/10/28.
//
//

#import "CartGetByMemberResponse.h"

@implementation CartGetByMemberResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.member=[MemberTable mj_objectWithKeyValues:response.data[@"member"]];
        
        self.cartlist=[ItemTable mj_objectArrayWithKeyValuesArray:response.data[@"list"]];
    }
    return self;
}


@end
