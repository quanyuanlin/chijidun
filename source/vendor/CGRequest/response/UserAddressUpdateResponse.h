//
//  UserAddressUpdateResponse.h
//  chijidun
//
//  Created by iMac on 16/11/17.
//
//

#import <Foundation/Foundation.h>

@interface UserAddressUpdateResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;



@end
