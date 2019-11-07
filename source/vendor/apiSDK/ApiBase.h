#import <Foundation/Foundation.h>

@interface ApiBase : NSObject
- (NSMutableArray *)arrayFormat:(id)data;

- (NSString *)stringFormat:(id)data;

- (NSString *)JSONItemFormat:(NSString *)format data:(NSString *)data;
@end
