/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Tuan_itemTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *item_title;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *mname;
@property(strong, nonatomic) NSString *nums;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *pos_lat;
@property(strong, nonatomic) NSString *pos_lng;
@property(strong, nonatomic) NSString *tuan_id;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *units;

@end