//
//  OrderGetTimeIntervalResponse.h
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import <Foundation/Foundation.h>
#import "OrderTimeIntervalTable.h"

@class OrderTimeIntervalTable;
@interface OrderGetTimeIntervalResponse : NSObject


@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *hasLeft;
@property(nonatomic,strong) NSString *hasRight;

@property(nonatomic,strong) NSArray/*OrderTimeIntervalTable*/ *list;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@end
