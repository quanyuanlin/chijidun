/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface QuanListsRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *order;
@property(strong, nonatomic) NSString *order_by;
@property(strong, nonatomic) NSString *order_user;
@property(strong, nonatomic) NSString *page;
@property(strong, nonatomic) NSString *perPage;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *used_status;
@property(strong, nonatomic) NSString *used_uid;

@end