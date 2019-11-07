/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface TeamAddRequest : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *address;
@property(strong, nonatomic) NSString *area;
@property(strong, nonatomic) NSString *city;
@property(strong, nonatomic) NSString *invoice;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *names;
@property(strong, nonatomic) NSString *nums;
@property(strong, nonatomic) NSString *price;
@property(strong, nonatomic) NSString *province;
@property(strong, nonatomic) NSString *remark;
@property(strong, nonatomic) NSString *team_name;
@property(strong, nonatomic) NSString *tele;
@property(strong, nonatomic) NSString *times;
@property(strong, nonatomic) NSString *type;

@end