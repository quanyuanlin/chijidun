/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "SmsSend_verify_codeData.h"

@class SmsSend_verify_codeData;

@interface SmsSend_verify_codeResponse : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) SmsSend_verify_codeData *data;
@property(strong, nonatomic) NSString *result;
@property(strong, nonatomic) NSString *status;

@end