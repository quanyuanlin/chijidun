/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Member_applyTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *tele;
@property(strong, nonatomic) NSString *username;

@end