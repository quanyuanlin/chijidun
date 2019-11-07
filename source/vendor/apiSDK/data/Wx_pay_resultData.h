/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Wx_pay_resultData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *appid;
@property(strong, nonatomic) NSString *noncestr;
@property(strong, nonatomic) NSString *package;
@property(strong, nonatomic) NSString *partnerid;
@property(strong, nonatomic) NSString *prepayid;
@property(strong, nonatomic) NSString *sign;
@property(strong, nonatomic) NSString *signstr;
@property(strong, nonatomic) NSString *timestamp;

@end