#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extend)
+ (void)saveJsonForKey:(NSString *)key data:(NSString *)data;

+ (NSMutableDictionary *)getJsonForKey:(NSString *)key;

+ (void)saveDataForKey:(NSString *)key data:(id)data;

+ (NSMutableDictionary *)getDataForKey:(NSString *)key;
@end