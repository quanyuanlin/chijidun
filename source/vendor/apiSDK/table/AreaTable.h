/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface AreaTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *city_id;
@property(strong, nonatomic) NSString *city_name;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *update_time;

@end