/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface AdboardTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *description;
@property(strong, nonatomic) NSString *height;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *tpl;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *width;

@end