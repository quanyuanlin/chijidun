/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "QuanTable.h"

@class QuanTable;

@interface QuanGetResponse : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) QuanTable *data;
@property(strong, nonatomic) NSString *result;
@property(strong, nonatomic) NSString *status;

@end