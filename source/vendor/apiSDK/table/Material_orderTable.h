/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Material_orderTable : ApiBase
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
@property(strong, nonatomic) NSString *express;
@property(strong, nonatomic) NSString *express_info;
@property(strong, nonatomic) NSString *express_name;
@property(strong, nonatomic) NSString *express_remark;
@property(strong, nonatomic) NSString *express_sn;
@property(strong, nonatomic) NSString *express_tele;
@property(strong, nonatomic) NSString *express_time;
@property(strong, nonatomic) NSString *express_type;
@property(strong, nonatomic) NSString *get_time;
@property(strong, nonatomic) NSString *htotal;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *is_delete;
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
@property(strong, nonatomic) NSString *refund_reason;
@property(strong, nonatomic) NSString *refund_sn;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *type;

@end