/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface MeetTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *abst;
@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *img;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *price;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *title;

@end