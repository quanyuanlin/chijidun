/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "Score_listData.h"

@class Score_listData;

@interface UserScore_listData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSMutableArray/*Score_listData*/ *list;

@end