//
//  UserAddressListsResponse.h
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import <Foundation/Foundation.h>
#import "UserAddressTable.h"

@class UserAddressTable;
@interface UserAddressListsResponse : NSObject

@property(nonatomic,strong)NSArray /*UserAddressTable*/ *list;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;


@end
