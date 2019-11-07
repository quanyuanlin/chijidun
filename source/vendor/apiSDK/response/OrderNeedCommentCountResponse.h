/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "OrderNeedCommentCountData.h"

@class OrderNeedCommentCountData;

@interface OrderNeedCommentCountResponse : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) OrderNeedCommentCountData *data;
@property(strong, nonatomic) NSString *result;
@property(strong, nonatomic) NSString *status;

@end