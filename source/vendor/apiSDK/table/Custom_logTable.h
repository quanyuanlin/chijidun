/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Custom_logTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *num;
@property(strong, nonatomic) NSString *pos_lat;
@property(strong, nonatomic) NSString *pos_lng;
@property(strong, nonatomic) NSString *stime;
@property(strong, nonatomic) NSString *tele;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *uid;

@end