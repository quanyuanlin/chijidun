/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface OrderNeedCommentCountData : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *count;

@end