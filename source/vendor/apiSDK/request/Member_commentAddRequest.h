/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Member_commentAddRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSMutableArray/*NSString*/ *imgs;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *order_id;

@end