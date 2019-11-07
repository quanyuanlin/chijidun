//
//  DeleteOrderResponse.h
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import <Foundation/Foundation.h>

@interface DeleteOrderResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;


@end
