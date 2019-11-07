/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface User_msgtipTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *num;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *uid;

@end