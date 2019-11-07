//
//  UserAddressAutoResponse.h
//  chijidun
//
//  Created by iMac on 16/11/17.
//
//

#import <Foundation/Foundation.h>
#import "UserAddressTable.h"

@class UserAddressTable;
@interface UserAddressAutoResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@property(nonatomic,strong)UserAddressTable *address;

@end
