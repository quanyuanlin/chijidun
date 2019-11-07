#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreData/CoreData.h>
#import <XZFramework/TabBarController.h>
#import <XZFramework/TabBarItem.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import "GuideVC.h"
#import "ADViewController.h"
#import "TeamViewController.h"
#import "FindViewController.h"
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, WeiboSDKDelegate, WXApiDelegate,TabBarControllerDelegate>
+ (AppDelegate *)appDelegate;

@property(strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) TabBarController* viewController;
@property(readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property(readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(strong, nonatomic) NSString *wbtoken;
@property(strong, nonatomic) NSString *wbCurrentUserID;
@property(strong, nonatomic) id <WeiboSDKDelegate> delegate_weibo;
@property(strong, nonatomic) id <WXApiDelegate> delegate_wx;

@property(nonatomic,strong)NSString *waitNum;
- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

-(void)setTabVCWith:(NSInteger)index;

-(void)setTabNumWith:(NSString *)num;

@property(nonatomic,strong)UILabel *labNum;

@end

