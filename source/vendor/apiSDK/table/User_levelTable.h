/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface User_levelTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *max;
@property(strong, nonatomic) NSString *min;
@property(strong, nonatomic) NSString *title;

@end