//
//  OrderPayListResponse.h
//  chijidun
//
//  Created by iMac on 16/11/18.
//
//

#import <Foundation/Foundation.h>

@interface OrderPayListResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@property(nonatomic,strong)NSArray *payList;


@end
