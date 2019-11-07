/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Custom_itemListsRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *page;
@property(strong, nonatomic) NSString *perPage;
@property(strong, nonatomic) NSString *totalPage;

@end