/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "Member_commentTable.h"
#import "PageInfoData.h"

@class Member_commentTable;
@class PageInfoData;

@interface Member_commentListsData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSMutableArray/*Member_commentTable*/ *list;
@property(strong, nonatomic) PageInfoData *pageInfo;

@end