/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Item_skuTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *cate_id;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *nums;

@end