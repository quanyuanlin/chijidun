/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Express_logsTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *express_list;
@property(strong, nonatomic) NSString *express_name;
@property(strong, nonatomic) NSString *express_sn;
@property(strong, nonatomic) NSString *Id;

@end