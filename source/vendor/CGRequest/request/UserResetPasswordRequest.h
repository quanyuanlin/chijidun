//
//  UserResetPasswordRequest.h
//  chijidun
//
//  Created by iMac on 16/8/29.
//
//

#import <Foundation/Foundation.h>

@interface UserResetPasswordRequest : NSObject

@property(nonatomic,strong) NSString *tele;
@property(nonatomic,strong) NSString *newpassword;
@property(nonatomic,strong) NSString *oldpassword;
@property(nonatomic,strong) NSString *code;

@end
