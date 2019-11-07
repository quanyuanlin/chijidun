/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface TopicTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *admin_id;
@property(strong, nonatomic) NSString *cate_id;
@property(strong, nonatomic) NSString *etime;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *img;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *maxs;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *prices;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *stime;
@property(strong, nonatomic) NSString *title;

@end