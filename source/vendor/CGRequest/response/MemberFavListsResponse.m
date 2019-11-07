//
//  MemberFavListsResponse.m
//  chijidun
//
//  Created by iMac on 16/11/19.
//
//

#import "MemberFavListsResponse.h"

@implementation MemberFavListsResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.list=[MemberFavTable mj_objectArrayWithKeyValuesArray:response.data[@"list"]];        
        for (MemberFavTable *fav in self.list) {
            fav.member=[MemberTable mj_objectWithKeyValues:fav.member];
        }
        
    }
    return self;
}


@end
