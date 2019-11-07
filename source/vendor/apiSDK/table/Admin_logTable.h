/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Admin_logTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *actions;
@property(strong, nonatomic) NSString *admin_id;
@property(strong, nonatomic) NSString *admin_name;
@property(strong, nonatomic) NSString *admin_time;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *ip;
@property(strong, nonatomic) NSString *remark;

@end