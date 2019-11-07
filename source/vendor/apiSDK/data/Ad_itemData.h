/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Ad_itemData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *adclicktype;
@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *app_type;

@end