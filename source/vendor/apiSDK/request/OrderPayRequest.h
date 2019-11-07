/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface OrderPayRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *pays;
@property(strong, nonatomic) NSString *pays_id;
@property(strong, nonatomic) NSString *platform;

@end