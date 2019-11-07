/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface HotsTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *hits;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *last_time;
@property(strong, nonatomic) NSString *name;

@end