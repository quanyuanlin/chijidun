/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface User_bindTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *access_token;
@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *keyid;
@property(strong, nonatomic) NSString *refresh_token;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *uid;

@end