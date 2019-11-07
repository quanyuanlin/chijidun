/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface User_statTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *action;
@property(strong, nonatomic) NSString *last_time;
@property(strong, nonatomic) NSString *num;
@property(strong, nonatomic) NSString *uid;

@end