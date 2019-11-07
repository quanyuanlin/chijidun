/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Material_order_itemTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *attr;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *is_refund;
@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *mname;
@property(strong, nonatomic) NSString *num;
@property(strong, nonatomic) NSString *order_id;
@property(strong, nonatomic) NSString *orderid;
@property(strong, nonatomic) NSString *price;
@property(strong, nonatomic) NSString *remark;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *title;

@end