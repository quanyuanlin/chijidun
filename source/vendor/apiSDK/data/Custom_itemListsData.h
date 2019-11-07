/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "Custom_itemTable.h"
#import "PageInfoData.h"

@class Custom_itemTable;
@class PageInfoData;

@interface Custom_itemListsData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSMutableArray/*Custom_itemTable*/ *list;
@property(strong, nonatomic) PageInfoData *pageInfo;

@end