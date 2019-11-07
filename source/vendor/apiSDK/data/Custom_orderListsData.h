/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "Custom_orderTable.h"
#import "PageInfoData.h"

@class Custom_orderTable;
@class PageInfoData;

@interface Custom_orderListsData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSMutableArray/*Custom_orderTable*/ *list;
@property(strong, nonatomic) PageInfoData *pageInfo;

@end