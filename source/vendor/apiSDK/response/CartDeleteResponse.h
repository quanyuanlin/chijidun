/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface CartDeleteResponse : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *data;
@property(strong, nonatomic) NSString *result;
@property(strong, nonatomic) NSString *status;

@end