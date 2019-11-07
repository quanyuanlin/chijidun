/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Member_giveTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *card_id;
@property(strong, nonatomic) NSString *check_name;
@property(strong, nonatomic) NSString *check_remark;
@property(strong, nonatomic) NSString *check_time;
@property(strong, nonatomic) NSString *check_uid;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *mname;
@property(strong, nonatomic) NSString *money;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *total;

@end