//
//  OrderAddResponse.h
//  chijidun
//
//  Created by iMac on 16/10/31.
//
//

#import <Foundation/Foundation.h>
#import "OrderTable.h"

@interface OrderAddResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@property(nonatomic,strong)OrderTable  *order;

@end
