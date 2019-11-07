/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface User_trendTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *data_content;
@property(strong, nonatomic) NSString *data_id;
@property(strong, nonatomic) NSString *data_type;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *uname;

@end