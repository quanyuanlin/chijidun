/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Member_commentListsRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *page;
@property(strong, nonatomic) NSString *perPage;
@property(strong, nonatomic) NSString *reply;

@end