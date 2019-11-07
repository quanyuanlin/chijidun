/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface User_bindCallbackRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *img;
@property(strong, nonatomic) NSString *keyid;
@property(strong, nonatomic) NSString *nickname;
@property(strong, nonatomic) NSString *type;

@end