//
//  CartGetByMemberResponse.h
//  chijidun
//
//  Created by iMac on 16/10/28.
//
//

#import <Foundation/Foundation.h>
#import "MemberTable.h"

@class MemberTable;
@interface CartGetByMemberResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;


@property(nonatomic,strong)NSArray /*ItemTable*/ *cartlist;
@property(nonatomic,strong)MemberTable  *member;

@end
