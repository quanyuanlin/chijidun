//
//  CharacterAppPayRequest.h
//  chijidun
//
//  Created by iMac on 16/10/12.
//
//

#import <Foundation/Foundation.h>

@interface CharacterAppPayRequest : NSObject

@property(nonatomic,strong)NSString *preorder_id;
@property(nonatomic,strong)NSString *user_auth_code;
@property(nonatomic,strong)NSString *captcha;

@end
