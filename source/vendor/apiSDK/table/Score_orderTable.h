/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Score_orderTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *address;
@property(strong, nonatomic) NSString *consignee;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *item_name;
@property(strong, nonatomic) NSString *item_num;
@property(strong, nonatomic) NSString *mobile;
@property(strong, nonatomic) NSString *order_score;
@property(strong, nonatomic) NSString *order_sn;
@property(strong, nonatomic) NSString *remark;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *uname;
@property(strong, nonatomic) NSString *zip;

@end