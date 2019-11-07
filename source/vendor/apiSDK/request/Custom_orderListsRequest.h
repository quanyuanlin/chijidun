/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Custom_orderListsRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *page;
@property(strong, nonatomic) NSString *perPage;
@property(strong, nonatomic) NSString *totalPage;
@property(strong, nonatomic) NSString *uid;

@end