/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface ArticleTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *author;
@property(strong, nonatomic) NSString *cate_id;
@property(strong, nonatomic) NSString *colors;
@property(strong, nonatomic) NSString *comments;
@property(strong, nonatomic) NSString *hits;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *img;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *intro;
@property(strong, nonatomic) NSString *last_time;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *seo_desc;
@property(strong, nonatomic) NSString *seo_keys;
@property(strong, nonatomic) NSString *seo_title;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *tags;
@property(strong, nonatomic) NSString *title;

@end