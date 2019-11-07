/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "Ali_pay_resultData.h"
#import "Wx_pay_resultData.h"

@class Ali_pay_resultData;
@class Wx_pay_resultData;

@interface Custom_orderPayData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) Ali_pay_resultData *ali_pay_result;
@property(strong, nonatomic) NSString *pays;
@property(strong, nonatomic) Wx_pay_resultData *wx_pay_result;

@end