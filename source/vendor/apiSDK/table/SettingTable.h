/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface SettingTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *data;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *remark;

@end