//
//  ConfirmOrderResponse.h
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import <Foundation/Foundation.h>
#import "ChefTable.h"
#import "TeamAddressTable.h"

@interface ConfirmOrderResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@property(nonatomic,strong) NSArray/*ChefItemTable*/ *list;

@property(nonatomic,strong) NSString *total;
@property(nonatomic,strong) NSString *companyPay;
@property(nonatomic,strong) NSString *userPay;

@property(nonatomic,strong) NSArray/*TeamAddressTable*/ *address;
@property(nonatomic,strong) NSString *mealTime;
@property(nonatomic,strong) NSString *category;
@property(nonatomic,strong) NSString *payType;

@end
