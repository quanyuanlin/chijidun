//
//  UserRegisterResponse.h
//  chijidun
//
//  Created by iMac on 16/8/28.
//
//

#import <Foundation/Foundation.h>

@interface UserRegisterResponse : NSObject

@property(nonatomic,strong) NSString *data;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@end
