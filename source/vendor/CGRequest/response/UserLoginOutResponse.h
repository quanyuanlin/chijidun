//
//  UserLoginOutResponse.h
//  chijidun
//
//  Created by iMac on 16/9/1.
//
//

#import <Foundation/Foundation.h>

@interface UserLoginOutResponse : NSObject

@property(nonatomic,strong) NSString *data;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;


@end
