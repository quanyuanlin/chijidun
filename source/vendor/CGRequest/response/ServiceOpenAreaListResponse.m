//
//  ServiceOpenAreaListResponse.m
//  chijidun
//
//  Created by iMac on 16/11/18.
//
//

#import "ServiceOpenAreaListResponse.h"

@implementation ServiceOpenAreaListResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.list=response.data[@"list"];
    }
    return self;
}


@end
