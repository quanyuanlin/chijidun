/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Score_logTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *action;
@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *score;
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *uname;

@end