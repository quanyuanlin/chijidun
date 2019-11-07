/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "QuanTable.h"

@class QuanTable;

@interface QuanListsData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSMutableArray/*QuanTable*/ *list;

@end