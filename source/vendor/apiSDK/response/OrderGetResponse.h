/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "OrderTable.h"

@class OrderTable;

@interface OrderGetResponse : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) OrderTable *data;
@property(strong, nonatomic) NSString *result;
@property(strong, nonatomic) NSString *status;

@end