//
//  UserLoginNewResponse.h
//  chijidun
//
//  Created by iMac on 16/8/28.
//
//

#import <Foundation/Foundation.h>
#import "UserTable.h"

@class UserTable;
@interface UserLoginNewResponse : NSObject

@property(nonatomic,strong) UserTable *data;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@end
