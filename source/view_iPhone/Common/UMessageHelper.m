#import "UMessageHelper.h"
#import "UMessage.h"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000


@implementation UMessageHelper {

}
+ (void)setup:(NSString *)appKey launchOptions:(NSDictionary *)launchOptions {

    [UMessage startWithAppkey:appKey launchOptions:launchOptions];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if (UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title = @"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序

        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title = @"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;

        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1, action2] forContext:(UIUserNotificationActionContextDefault)];

//        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert
//                                                                                     categories:[NSSet setWithObject:categorys]];
//        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        [UMessage registerForRemoteNotifications];

    } else {
        //register remoteNotification types (iOS 8.0以下)
//        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
//                | UIRemoteNotificationTypeSound
//                | UIRemoteNotificationTypeAlert];
        [UMessage registerForRemoteNotifications];
    }
#else

    //register remoteNotification types (iOS 8.0以下)
[UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
 |UIRemoteNotificationTypeSound
 |UIRemoteNotificationTypeAlert];

#endif
    [UMessage setLogEnabled:YES];
}

+ (void)registerDeviceToken:(NSData *)deviceToken {
    [UMessage registerDeviceToken:deviceToken];
}

+ (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [UMessage didReceiveRemoteNotification:userInfo];
}
+ (void)setAutoAlert:(BOOL)show
{
    [UMessage setAutoAlert:show];
}
@end




