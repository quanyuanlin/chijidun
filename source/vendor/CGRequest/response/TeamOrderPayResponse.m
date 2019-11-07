//
//  TeamOrderPayResponse.m
//  chijidun
//
//  Created by iMac on 16/9/28.
//
//

#import "TeamOrderPayResponse.h"

@implementation TeamOrderPayResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.data=response.data;
        self.code=response.code;
    }
    return self;
}


@end
