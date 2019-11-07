/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "Ad_appTable.h"

@class Ad_appTable;

@interface IndexGetData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSMutableArray/*Ad_appTable*/ *list;

@end
