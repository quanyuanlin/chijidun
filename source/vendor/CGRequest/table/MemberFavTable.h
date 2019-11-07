//
//  MemberFavTable.h
//  chijidun
//
//  Created by iMac on 16/11/19.
//
//

#import <Foundation/Foundation.h>
#import "MemberTable.h"

@class MemberTable;
@interface MemberFavTable : NSObject

@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) MemberTable *member;


@end
