/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Custom_likeTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *custom_id;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *like_id;

@end