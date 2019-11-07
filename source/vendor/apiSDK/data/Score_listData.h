/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Score_listData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *desc;
@property(strong, nonatomic) NSString *score;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *type;

@end