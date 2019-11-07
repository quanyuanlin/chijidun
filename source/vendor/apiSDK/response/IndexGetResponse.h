/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "IndexGetData.h"

@class IndexGetData;

@interface IndexGetResponse : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) IndexGetData *data;
@property(strong, nonatomic) NSString *result;
@property(strong, nonatomic) NSString *status;

@end