/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "CartDeleteParamsData.h"

@class CartDeleteParamsData;

@interface CartDeleteRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSMutableArray/*CartDeleteParamsData*/ *items;

@end