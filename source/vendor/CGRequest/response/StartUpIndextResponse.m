//
//  StartUpIndextResponse.m
//  chijidun
//
//  Created by iMac on 16/9/2.
//
//

#import "StartUpIndextResponse.h"

@implementation StartUpIndextResponse

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