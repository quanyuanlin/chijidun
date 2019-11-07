/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface MessageAddRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *from_uid;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *title;

@end