/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface CartUpdateRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *attr;
@property(strong, nonatomic) NSString *days;
@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *num;

@end