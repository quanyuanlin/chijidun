/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Flink_cateTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *status;

@end