/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Article_cateTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *alias;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *img;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *pid;
@property(strong, nonatomic) NSString *seo_desc;
@property(strong, nonatomic) NSString *seo_keys;
@property(strong, nonatomic) NSString *seo_title;
@property(strong, nonatomic) NSString *spid;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *type;

@end