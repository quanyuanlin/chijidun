/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Article_pageTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *cate_id;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *last_time;
@property(strong, nonatomic) NSString *seo_desc;
@property(strong, nonatomic) NSString *seo_keys;
@property(strong, nonatomic) NSString *seo_title;
@property(strong, nonatomic) NSString *title;

@end