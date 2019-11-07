/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface OauthTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *author;
@property(strong, nonatomic) NSString *code;
@property(strong, nonatomic) NSString *config;
@property(strong, nonatomic) NSString *desc;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *status;

@end