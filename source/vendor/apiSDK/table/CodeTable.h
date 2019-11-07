/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface CodeTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *code;
@property(strong, nonatomic) NSString *ctime;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *tele;

@end