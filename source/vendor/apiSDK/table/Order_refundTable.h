/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Order_refundTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *account;
@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *admin_id;
@property(strong, nonatomic) NSString *admin_name;
@property(strong, nonatomic) NSString *alipay_name;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *order_id;
@property(strong, nonatomic) NSString *order_price;
@property(strong, nonatomic) NSString *orderid;
@property(strong, nonatomic) NSString *remark;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *uname;

@end