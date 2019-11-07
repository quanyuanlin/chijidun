/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "UserMemberReplyUncheckCountData.h"

@class UserMemberReplyUncheckCountData;

@interface UserMemberReplyUncheckCountResponse : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) UserMemberReplyUncheckCountData *data;
@property(strong, nonatomic) NSString *result;
@property(strong, nonatomic) NSString *status;

@end