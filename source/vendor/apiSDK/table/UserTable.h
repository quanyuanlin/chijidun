/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface UserTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *address;
@property(strong, nonatomic) NSString *area;
@property(strong, nonatomic) NSString *area_id;
@property(strong, nonatomic) NSString *birthday;
@property(strong, nonatomic) NSString *city;
@property(strong, nonatomic) NSString *city_id;
@property(strong, nonatomic) NSString *company_id;
@property(strong, nonatomic) NSString *cover;
@property(strong, nonatomic) NSString *deviceid;
@property(strong, nonatomic) NSString *email;
@property(strong, nonatomic) NSString *favs;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *img;
@property(strong, nonatomic) NSString *intro;
@property(strong, nonatomic) NSString *is_qq_bind;
@property(strong, nonatomic) NSString *is_vip;
@property(strong, nonatomic) NSString *is_weibo_bind;
@property(strong, nonatomic) NSString *is_weixin_bind;
@property(strong, nonatomic) NSString *last_dev;
@property(strong, nonatomic) NSString *last_ip;
@property(strong, nonatomic) NSString *last_lat;
@property(strong, nonatomic) NSString *last_lng;
@property(strong, nonatomic) NSString *last_sys;
@property(strong, nonatomic) NSString *last_time;
@property(strong, nonatomic) NSString *level;
@property(strong, nonatomic) NSString *likes;
@property(strong, nonatomic) NSString *member_reply_uncheck_count;
@property(strong, nonatomic) NSString *msg_express;
@property(strong, nonatomic) NSString *msg_sales;
@property(strong, nonatomic) NSString *msg_sys;
@property(strong, nonatomic) NSString *openid;
@property(strong, nonatomic) NSString *orders;
@property(strong, nonatomic) NSString *password;
@property(strong, nonatomic) NSString *province;
@property(strong, nonatomic) NSString *province_id;
@property(strong, nonatomic) NSString *quans;
@property(strong, nonatomic) NSString *reg_dev;
@property(strong, nonatomic) NSString *reg_ip;
@property(strong, nonatomic) NSString *reg_time;
@property(strong, nonatomic) NSString *score;
@property(strong, nonatomic) NSString *sex;
@property(strong, nonatomic) NSString *sign;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *tele;
@property(strong, nonatomic) NSString *url;
@property(strong, nonatomic) NSString *username;
@property(strong, nonatomic) NSString *weibo;
@property(strong, nonatomic) NSString *weixin;

@property(strong, nonatomic) NSString *token;


@end



