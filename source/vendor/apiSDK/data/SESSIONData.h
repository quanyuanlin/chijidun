/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface SESSIONData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *member_type;
@property(strong, nonatomic) NSString *token;
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *username;

@end