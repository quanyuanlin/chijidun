/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "Custom_itemListsData.h"

@class Custom_itemListsData;

@interface Custom_itemListsResponse : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) Custom_itemListsData *data;
@property(strong, nonatomic) NSString *result;
@property(strong, nonatomic) NSString *status;

@end