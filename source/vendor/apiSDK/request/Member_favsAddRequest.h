/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Member_favsAddRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *mid;

@end