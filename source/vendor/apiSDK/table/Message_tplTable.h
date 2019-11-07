/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Message_tplTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *alias;
@property(strong, nonatomic) NSString *content;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *is_sys;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *type;

@end