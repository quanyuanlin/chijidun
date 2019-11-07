/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Topic_itemTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *topic_id;

@end