/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Member_tagsTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *member_id;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *status;

@end