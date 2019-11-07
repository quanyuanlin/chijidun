//
//  UserResetPasswordResponse.h
//  chijidun
//
//  Created by iMac on 16/8/29.
//
//

#import <Foundation/Foundation.h>

@interface UserResetPasswordResponse : NSObject

@property(nonatomic,strong) NSString *data;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@end
