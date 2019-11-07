/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface OrderAdd_order_refundRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *account;
@property(strong, nonatomic) NSString *alipay_name;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *order_id;
@property(strong, nonatomic) NSString *remark;
@property(strong, nonatomic) NSString *type;

@end