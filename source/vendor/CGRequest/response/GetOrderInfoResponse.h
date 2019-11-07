//
//  GetOrderInfoResponse.h
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import <Foundation/Foundation.h>

@interface GetOrderInfoResponse : NSObject

@property(nonatomic,strong)TeamOrderTable *order;
@property(nonatomic,strong)NSArray/*ChefItemTable*/ *items;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@end
