/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface QuanTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *code;
@property(strong, nonatomic) NSString *etime;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *img;
@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *man_price;
@property(strong, nonatomic) NSString *man_sale;
@property(strong, nonatomic) NSString *max;
@property(strong, nonatomic) NSString *price;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *stime;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *uname;
@property(strong, nonatomic) NSString *used_status;
@property(strong, nonatomic) NSString *used_time;
@property(strong, nonatomic) NSString *used_uid;

@end