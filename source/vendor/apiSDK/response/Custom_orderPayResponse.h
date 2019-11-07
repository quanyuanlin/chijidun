/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "Custom_orderPayData.h"

@class Custom_orderPayData;

@interface Custom_orderPayResponse : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) Custom_orderPayData *data;
@property(strong, nonatomic) NSString *result;
@property(strong, nonatomic) NSString *status;

@end