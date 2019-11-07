/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "UserTable.h"

@class UserTable;

@interface UserGetResponse : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) UserTable *data;
@property(strong, nonatomic) NSString *result;
@property(strong, nonatomic) NSString *status;

@end