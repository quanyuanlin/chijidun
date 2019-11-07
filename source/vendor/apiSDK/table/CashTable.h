/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface CashTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *admin_id;
@property(strong, nonatomic) NSString *admin_name;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *mname;
@property(strong, nonatomic) NSString *nums;
@property(strong, nonatomic) NSString *order_id;
@property(strong, nonatomic) NSString *orderid;
@property(strong, nonatomic) NSString *price;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *total;

@end