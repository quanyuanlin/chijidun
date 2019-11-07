/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "Hot_itemData.h"
#import "ItemTable.h"
#import "Member_imgTable.h"

@class Hot_itemData;
@class ItemTable;
@class Member_imgTable;

@interface MemberTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *address;
@property(strong, nonatomic) NSString *admin_id;
@property(strong, nonatomic) NSString *area;
@property(strong, nonatomic) NSString *area_id;
@property(strong, nonatomic) NSString *birthday;
@property(strong, nonatomic) NSString *caixi;
@property(strong, nonatomic) NSString *card_bg;
@property(strong, nonatomic) NSString *card_fr;
@property(strong, nonatomic) NSString *city;
@property(strong, nonatomic) NSString *city_id;
@property(strong, nonatomic) NSString *comment_num;
@property(strong, nonatomic) NSMutableArray/*Member_imgTable*/ *covers;
@property(strong, nonatomic) NSString *deviceid;
@property(strong, nonatomic) NSString *email;
@property(strong, nonatomic) NSString *etime;
@property(strong, nonatomic) NSString *fahuo_address;
@property(strong, nonatomic) NSString *favs;
@property(strong, nonatomic) NSString *health;
@property(strong, nonatomic) NSMutableArray/*Hot_itemData*/ *hot_items;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *idcard;
@property(strong, nonatomic) NSString *img;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *is_check;
@property(strong, nonatomic) NSString *is_member_favs;
@property(strong, nonatomic) NSString *is_open;
@property(strong, nonatomic) NSString *is_take;
@property(strong, nonatomic) NSMutableArray/*ItemTable*/ *items;
@property(strong, nonatomic) NSString *last_dev;
@property(strong, nonatomic) NSString *last_ip;
@property(strong, nonatomic) NSString *last_lat;
@property(strong, nonatomic) NSString *last_lng;
@property(strong, nonatomic) NSString *last_sys;
@property(strong, nonatomic) NSString *last_time;
@property(strong, nonatomic) NSString *likes;
@property(strong, nonatomic) NSMutableArray/*Member_imgTable*/ *member_img;
@property(strong, nonatomic) NSString *min_price;
@property(strong, nonatomic) NSString *min_range;
@property(strong, nonatomic) NSString *money;
@property(strong, nonatomic) NSString *mosaic_card;
@property(strong, nonatomic) NSString *mosaic_health;
@property(strong, nonatomic) NSString *notice;
@property(strong, nonatomic) NSString *order_capability;
@property(strong, nonatomic) NSString *orders;
@property(strong, nonatomic) NSString *sales;
@property(strong, nonatomic) NSString *password;
@property(strong, nonatomic) NSString *phone;
@property(strong, nonatomic) NSString *pos_lat;
@property(strong, nonatomic) NSString *pos_lng;
@property(strong, nonatomic) NSString *province;
@property(strong, nonatomic) NSString *province_id;
@property(strong, nonatomic) NSString *reg_dev;
@property(strong, nonatomic) NSString *reg_ip;
@property(strong, nonatomic) NSString *reg_time;
@property(strong, nonatomic) NSString *score;
@property(strong, nonatomic) NSString *service_capability;
@property(strong, nonatomic) NSString *sex;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *statusStr;
@property(strong, nonatomic) NSString *stime;
@property(strong, nonatomic) NSString *tele;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *total;
@property(strong, nonatomic) NSString *town;
@property(strong, nonatomic) NSString *username;
@property(strong, nonatomic) NSString *weeks;
@property(strong, nonatomic) NSString *hometown;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *distance;
@property(strong, nonatomic) NSString *statusTomorrow;
@property(strong, nonatomic) NSString *statusDistance;

@end




