/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface User_scoreTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *data;
@property(strong, nonatomic) NSString *desc;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *score;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *uid;

@end