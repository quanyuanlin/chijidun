/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Custom_itemIndexRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;


@end