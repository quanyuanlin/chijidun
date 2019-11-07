/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "Order_itemTable.h"

@class Order_itemTable;

@interface OrderTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *addr_address;
@property(strong, nonatomic) NSString *addr_area;
@property(strong, nonatomic) NSString *addr_city;
@property(strong, nonatomic) NSString *addr_name;
@property(strong, nonatomic) NSString *addr_province;
@property(strong, nonatomic) NSString *addr_tele;
@property(strong, nonatomic) NSString *addr_zipcode;
@property(strong, nonatomic) NSString *check_time;
@property(strong, nonatomic) NSString *check_uid;
@property(strong, nonatomic) NSString *days;
@property(strong, nonatomic) NSString *express;
@property(strong, nonatomic) NSString *express_info;
@property(strong, nonatomic) NSString *express_name;
@property(strong, nonatomic) NSString *express_remark;
@property(strong, nonatomic) NSString *express_sn;
@property(strong, nonatomic) NSString *express_tele;
@property(strong, nonatomic) NSString *express_time;
@property(strong, nonatomic) NSString *express_type;
@property(strong, nonatomic) NSString *htotal;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *intive;
@property(strong, nonatomic) NSString *is_delete;
@property(strong, nonatomic) NSMutableArray/*Order_itemTable*/ *items;
@property(strong, nonatomic) NSString *member_tele;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *mname;
@property(strong, nonatomic) NSString *orderid;
@property(strong, nonatomic) NSString *out_trade_no;
@property(strong, nonatomic) NSString *pays;
@property(strong, nonatomic) NSString *pays_data;
@property(strong, nonatomic) NSString *pays_id;
@property(strong, nonatomic) NSString *pays_price;
@property(strong, nonatomic) NSString *pays_sn;
@property(strong, nonatomic) NSString *pays_status;
@property(strong, nonatomic) NSString *pays_time;
@property(strong, nonatomic) NSString *ping_remark;
@property(strong, nonatomic) NSString *prices;
@property(strong, nonatomic) NSString *quan_id;
@property(strong, nonatomic) NSString *quan_price;
@property(strong, nonatomic) NSString *refund_reason;
@property(strong, nonatomic) NSString *refund_sn;
@property(strong, nonatomic) NSString *remark;
@property(strong, nonatomic) NSString *score;
@property(strong, nonatomic) NSString *service_id;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *times;
@property(strong, nonatomic) NSString *total;
@property(strong, nonatomic) NSString *trade_no;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *uname;
@property(strong, nonatomic) NSString *left_time;

@end




