/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Pay_logTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *ip;
@property(strong, nonatomic) NSString *order_id;
@property(strong, nonatomic) NSString *pays_data;
@property(strong, nonatomic) NSString *pays_id;

@end