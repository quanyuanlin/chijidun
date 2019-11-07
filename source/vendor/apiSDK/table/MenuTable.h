/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface MenuTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *action_name;
@property(strong, nonatomic) NSString *data;
@property(strong, nonatomic) NSString *display;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *module_name;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *often;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *pid;
@property(strong, nonatomic) NSString *remark;

@end