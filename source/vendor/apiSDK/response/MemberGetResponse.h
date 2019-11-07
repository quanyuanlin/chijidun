/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "MemberTable.h"

@class MemberTable;

@interface MemberGetResponse : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) MemberTable *data;
@property(strong, nonatomic) NSString *result;
@property(strong, nonatomic) NSString *status;

@end