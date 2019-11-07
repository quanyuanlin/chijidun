/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface MemberListsRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *page;
@property(strong, nonatomic) NSString *perPage;
@property(strong, nonatomic) NSString *pos_lat;
@property(strong, nonatomic) NSString *pos_lng;
@property(strong, nonatomic) NSString *city;

@end
