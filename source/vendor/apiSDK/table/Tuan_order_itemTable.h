/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Tuan_order_itemTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *date;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *item_ids;
@property(strong, nonatomic) NSString *item_num;
@property(strong, nonatomic) NSString *item_price;
@property(strong, nonatomic) NSString *item_title;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *mname;
@property(strong, nonatomic) NSString *nums;
@property(strong, nonatomic) NSString *order_id;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *tuan_id;

@end