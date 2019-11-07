//
//  MemberFavListsResponse.h
//  chijidun
//
//  Created by iMac on 16/11/19.
//
//

#import <Foundation/Foundation.h>
#import "MemberTable.h"
#import "MemberFavTable.h"

@class MemberTable;
@interface MemberFavListsResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@property(nonatomic,strong)NSArray *list;

@end
