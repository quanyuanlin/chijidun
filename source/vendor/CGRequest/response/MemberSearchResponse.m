//
//  MemberSearchResponse.m
//  chijidun
//
//  Created by iMac on 16/12/8.
//
//

#import "MemberSearchResponse.h"

@implementation MemberSearchResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:response.data];
        self.data =[[MemberListsData new]fromJSON:dict];

    }
    return self;
}


@end
