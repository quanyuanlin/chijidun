/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface CityTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *pid;
@property(strong, nonatomic) NSString *remark;
@property(strong, nonatomic) NSString *spid;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *update_time;

@end