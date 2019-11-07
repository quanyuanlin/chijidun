/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Custom_orderTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *address;
@property(strong, nonatomic) NSString *fruit;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *meat;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *nums;
@property(strong, nonatomic) NSString *pays;
@property(strong, nonatomic) NSString *pays_data;
@property(strong, nonatomic) NSString *pays_price;
@property(strong, nonatomic) NSString *pays_sn;
@property(strong, nonatomic) NSString *pays_status;
@property(strong, nonatomic) NSString *pays_time;
@property(strong, nonatomic) NSString *price;
@property(strong, nonatomic) NSString *remark;
@property(strong, nonatomic) NSString *soup;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *tele;
@property(strong, nonatomic) NSString *times;
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *uname;
@property(strong, nonatomic) NSString *vege;

@end