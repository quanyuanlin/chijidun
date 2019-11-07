//
//  TeamOrderTable.h
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import <Foundation/Foundation.h>

@interface TeamOrderTable : NSObject

@property(nonatomic,strong) NSArray /*ChefTable */ *list;

@property(nonatomic,strong) NSArray /*ChefTable */ *lis;
@property(nonatomic,strong) NSString *total;
@property(nonatomic,strong) NSString *pay;
@property(nonatomic,strong) NSString *notPay;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *Id;
@property(nonatomic,strong) NSString *excessTime;
@property(nonatomic,strong) NSString *statusStr;
@property(nonatomic,strong) NSString *menus;
@property(nonatomic,strong) NSString *category;

@property(nonatomic,strong) NSString *mealTime;
@property(nonatomic,strong) NSString *companyPay;
@property(nonatomic,strong) NSString *userPay;
@property(nonatomic,strong) NSString *payType;
@property(nonatomic,strong) NSString *endTime;
@property(nonatomic,strong) NSString *isToday;
@property(nonatomic,strong) NSString *isHistory;
@property(nonatomic,strong) NSString *payWay;
@property(nonatomic,strong) NSArray *payList;

@property(nonatomic,strong)NSString *order_id;
@property(nonatomic,strong)NSString *meal_type;
@property(nonatomic,strong)NSString *add_time;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *meal_time;
@property(nonatomic,strong)NSString *total_price;
@property(nonatomic,strong)NSString *itemStr;
@property(nonatomic,strong)NSString *week;
@property(nonatomic,strong)NSString *cancel;
@property(nonatomic,strong)NSString *countDown;

@end




