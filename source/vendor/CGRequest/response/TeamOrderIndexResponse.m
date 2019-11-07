//
//  TeamOrderIndexResponse.m
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import "TeamOrderIndexResponse.h"

@implementation TeamOrderIndexResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.lists=[OrderIndexTable mj_objectArrayWithKeyValuesArray:response.data[@"lists"]];
        self.company=[CompanyTable mj_objectWithKeyValues:response.data[@"company"]];
    }
    return self;
}


@end
