/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Member_device_tokensTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *last_time;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *platform;
@property(strong, nonatomic) NSString *token;

@end