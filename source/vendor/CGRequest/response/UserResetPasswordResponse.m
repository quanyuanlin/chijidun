//
//  UserResetPasswordResponse.m
//  chijidun
//
//  Created by iMac on 16/8/29.
//
//

#import "UserResetPasswordResponse.h"

@implementation UserResetPasswordResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.data=[NSString mj_objectWithKeyValues:response.data];
    }
    return self;
}


@end
