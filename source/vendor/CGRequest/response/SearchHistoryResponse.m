//
//  SearchHistoryResponse.m
//  chijidun
//
//  Created by iMac on 16/12/7.
//
//

#import "SearchHistoryResponse.h"

@implementation SearchHistoryResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
       
        NSMutableArray *array=[NSMutableArray array];
        for (NSDictionary *dict in response.data[@"list"]) {
            [array addObject:dict[@"key"]];
        }
        self.list=[NSArray arrayWithArray:array];
    }
    return self;
}


@end
