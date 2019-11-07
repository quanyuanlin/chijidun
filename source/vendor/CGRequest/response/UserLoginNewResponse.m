//
//  UserLoginNewResponse.m
//  chijidun
//
//  Created by iMac on 16/8/28.
//
//

#import "UserLoginNewResponse.h"

@implementation UserLoginNewResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.data=[UserTable mj_objectWithKeyValues:response.data];
    }
    return self;
}


@end
