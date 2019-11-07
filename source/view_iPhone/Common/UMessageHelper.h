#import <Foundation/Foundation.h>


@interface UMessageHelper : NSObject
+ (void)setup:(NSString *)appKey launchOptions:(NSDictionary *)launchOptions;

+ (void)registerDeviceToken:(NSData *)deviceToken;

+ (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

+ (void)setAutoAlert:(BOOL)show;

@end