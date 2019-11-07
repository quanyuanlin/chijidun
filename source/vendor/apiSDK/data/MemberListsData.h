/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "MemberTable.h"
#import "PageInfoData.h"

@class MemberTable;
@class PageInfoData;

@interface MemberListsData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSMutableArray/*MemberTable*/ *list;
@property(strong, nonatomic) PageInfoData *pageInfo;

@end