/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Admin_roleTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *remark;
@property(strong, nonatomic) NSString *status;

@end