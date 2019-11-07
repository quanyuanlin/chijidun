/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "CartTable.h"

@class CartTable;

@interface CartListByMemberData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *amount;
@property(strong, nonatomic) NSString *etime;
@property(strong, nonatomic) NSString *is_open;
@property(strong, nonatomic) NSMutableArray/*CartTable*/ *item_list;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *min_price;
@property(strong, nonatomic) NSString *mname;
@property(strong, nonatomic) NSString *stime;
@property(strong, nonatomic) NSString *weeks;

@end