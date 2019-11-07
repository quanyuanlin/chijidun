//
//  ItemGetDetailResponse.m
//  chijidun
//
//  Created by iMac on 16/12/8.
//
//

#import "ItemGetDetailResponse.h"

@implementation ItemGetDetailResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.item=[ChefItemTable mj_objectWithKeyValues:response.data];
    }
    return self;
}


@end
