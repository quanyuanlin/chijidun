/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Order_kuaidiTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *kuaidi_add;
@property(strong, nonatomic) NSString *kuaidi_name;
@property(strong, nonatomic) NSString *kuaidi_price;
@property(strong, nonatomic) NSString *kuaidi_remark;
@property(strong, nonatomic) NSString *kuaidi_sn;
@property(strong, nonatomic) NSString *kuaidi_status;
@property(strong, nonatomic) NSString *kuaidi_tele;
@property(strong, nonatomic) NSString *m_address;
@property(strong, nonatomic) NSString *m_id;
@property(strong, nonatomic) NSString *m_name;
@property(strong, nonatomic) NSString *m_tele;
@property(strong, nonatomic) NSString *order_id;
@property(strong, nonatomic) NSString *order_orderid;
@property(strong, nonatomic) NSString *order_prices;
@property(strong, nonatomic) NSString *order_times;
@property(strong, nonatomic) NSString *time_qiwang;
@property(strong, nonatomic) NSString *time_shiji;
@property(strong, nonatomic) NSString *time_wancheng;
@property(strong, nonatomic) NSString *u_address;
@property(strong, nonatomic) NSString *u_name;
@property(strong, nonatomic) NSString *u_tele;

@end