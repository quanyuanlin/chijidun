/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface MessageTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *from_uid;
@property(strong, nonatomic) NSString *from_uname;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *to_uid;
@property(strong, nonatomic) NSString *to_uname;

@end