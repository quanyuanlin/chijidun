/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface CartTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *attr;
@property(strong, nonatomic) NSString *days;
@property(strong, nonatomic) NSString *express;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *item_img;
@property(strong, nonatomic) NSString *item_title;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *mname;
@property(strong, nonatomic) NSString *num;
@property(strong, nonatomic) NSString *price;
@property(strong, nonatomic) NSString *uid;

@end