//
//  UserAddressAddResponse.h
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import <Foundation/Foundation.h>

@interface UserAddressAddResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;


@end
