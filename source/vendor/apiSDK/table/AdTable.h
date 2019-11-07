/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface AdTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *board_id;
@property(strong, nonatomic) NSString *clicks;
@property(strong, nonatomic) NSString *content;
@property(strong, nonatomic) NSString *desc;
@property(strong, nonatomic) NSString *end_time;
@property(strong, nonatomic) NSString *extimg;
@property(strong, nonatomic) NSString *extval;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *start_time;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *url;

@end