/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface AdminTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *email;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *last_ip;
@property(strong, nonatomic) NSString *last_time;
@property(strong, nonatomic) NSString *password;
@property(strong, nonatomic) NSString *role_id;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *username;

@end