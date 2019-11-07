//
//  AccountOrderResponse.h
//  chijidun
//
//  Created by iMac on 16/10/14.
//
//

#import <Foundation/Foundation.h>

@interface AccountOrderResponse : NSObject

@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)NSArray /*TeamOrderTable*/ *orderList;

@property(nonatomic,strong) NSString *mealType;
@property  BOOL isLast;


+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@end
