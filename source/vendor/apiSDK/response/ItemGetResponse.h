/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "ItemTable.h"

@class ItemTable;

@interface ItemGetResponse : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) ItemTable *data;
@property(strong, nonatomic) NSString *result;
@property(strong, nonatomic) NSString *status;

@end