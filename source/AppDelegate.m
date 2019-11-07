#import "AppDelegate.h"
#import "UserViewController.h"
#import "TeamOrderListVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "sys/utsname.h"
#import "BaiduMapHelper.h"
#import "UMessageHelper.h"
#import <UMMobClick/MobClick.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>

@interface AppDelegate () <UITabBarControllerDelegate>
{
    CGClient *appClient;
}
@end

@implementation AppDelegate {
}
+ (AppDelegate *)appDelegate; {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [BaiduMapHelper setup];
    //友盟消息
    [UMessageHelper setup:kUMengAppKey launchOptions:launchOptions];
    [UMessageHelper setAutoAlert:NO];
    
    //友盟统计
    UMConfigInstance.appKey = kUMengAppKey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setAppVersion:Current_Version];

    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = BG_COLOR;
    self.window.autoresizesSubviews = YES;
    self.window.rootViewController=[UIViewController new];

    [ShareSDK registerApp:@"9f084c0c8f70"];//字符串api20为您的ShareSDK的AppKey
    [ShareSDK connectSinaWeiboWithAppKey:kAppKey
                               appSecret:kAppSecret
                             redirectUri:kRedirectURI];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK connectSinaWeiboWithAppKey:kAppKey
                               appSecret:kAppSecret
                             redirectUri:kRedirectURI
                             weiboSDKCls:[WeiboSDK class]];

    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK  connectQQWithAppId:kQQAppKey qqApiCls:[QQApiInterface class]];


    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:kWXAppKey
                           wechatCls:[WXApi class]];
    //微信登陆的时候需要初始化
    [ShareSDK connectWeChatWithAppId:kWXAppKey
                           appSecret:kWXAppSecret
                           wechatCls:[WXApi class]];
    
    TConfig *config = [TConfig shared];
    config.APP_MAIN_COLOR = MAIN_COLOR;
    config.APP_SPLITE_COLOR = BG_COLOR;
    config.backendURL = API_URL;
    config.OAuthAccessTokenURL = kRedirectURI;
    App *app = [App shared];

    app.manager = [AFHTTPRequestOperationManager manager];
    app.manager.requestSerializer.HTTPShouldHandleCookies = YES;
    [app.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"accept"];
    [[UserBackend shared] restore];
    [[EmptyViewController shared] bind];

    [self setupViewControllers];
    [self.window makeKeyAndVisible];
    [self customizeInterface];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"nofirstLanuch"])
    {
        __weak AppDelegate *weakSelf = self;
        GuideVC *guide=[[GuideVC alloc]init];
        self.window.rootViewController = guide;
        guide.clickBlock=^(){
            weakSelf.window.rootViewController = weakSelf.viewController;
        };
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"nofirstLanuch"];
    }else{
        ADViewController *adVC=[[ADViewController alloc]init];
        self.window.rootViewController=adVC;
        
        [self checkVersion];
    }
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

#pragma mark- tabbarcontroller

- (void)setupViewControllers {
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    NSMutableArray *selectImages = [[NSMutableArray alloc] init];
    NSMutableArray *unSelectImages = [[NSMutableArray alloc] init];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.isFirst=YES;
    [controllers addObject:homeVC];
    [titles addObject:@"首页"];
    [selectImages addObject:@"ic_tab_home_select.png"];
    [unSelectImages addObject:@"ic_tab_home.png"];
    
    TeamOrderListVC *teamVC = [[TeamOrderListVC alloc] init];
    UDNavigationController *naviVC=[[UDNavigationController alloc]initWithRootViewController:teamVC];
    [controllers addObject:naviVC];
    [titles addObject:@"团餐"];
    [selectImages addObject:@"ic_tab_private_select.png"];
    [unSelectImages addObject:@"ic_tab_private.png"];
    
    
    FindViewController *findVC = [[FindViewController alloc] init];
    UDNavigationController *findiNC=[[UDNavigationController alloc]initWithRootViewController:findVC];
    [controllers addObject:findiNC];
    [titles addObject:@"发现"];
    [selectImages addObject:@"ic_tab_cart_select.png"];
    [unSelectImages addObject:@"ic_tab_cart.png"];

    UserViewController *userVC = [[UserViewController alloc] init];
    [controllers addObject:userVC];
    [titles addObject:@"我的"];
    [selectImages addObject:@"ic_tab_my_select.png"];
    [unSelectImages addObject:@"ic_tab_my.png"];

    TabBarController *tabBarController = [[TabBarController alloc] init];
    [tabBarController setViewControllers:controllers
                              withTitles:titles];
    tabBarController.selectedIndex = 0;
    tabBarController.delegate=self;
    self.viewController = tabBarController;

    NSInteger index = 0;
    for (TabBarItem *item in [[tabBarController tabBar] items]) {
        UIImage *selectedImage = [UIImage imageNamed:
                [NSString stringWithFormat:@"%@", selectImages[index]]];
        UIImage *unselectedImage = [UIImage imageNamed:
                [NSString stringWithFormat:@"%@", unSelectImages[index]]];

        NSDictionary *unselectedTitleAttributes;
        NSDictionary *selectedTitleAttributes;

        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
            unselectedTitleAttributes = @{
                    NSFontAttributeName : [UIFont systemFontOfSize:12],
                    NSForegroundColorAttributeName : TEXT_COLOR_DARK,
            };
            selectedTitleAttributes = @{
                    NSFontAttributeName : [UIFont systemFontOfSize:12],
                    NSForegroundColorAttributeName : MAIN_COLOR,
            };
        } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
            unselectedTitleAttributes = @{
                                          UITextAttributeFont: [UIFont systemFontOfSize:12],
                                          UITextAttributeTextColor:TEXT_COLOR_DARK,
                                          };
            selectedTitleAttributes = @{
                                        UITextAttributeFont: [UIFont systemFontOfSize:12],
                                        UITextAttributeTextColor:MAIN_COLOR,
                                        };
#endif
        }

        item.selectedTitleAttributes = selectedTitleAttributes;
        item.unselectedTitleAttributes = unselectedTitleAttributes;

        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
        index++;
    }
    
    [userVC loadData];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self loadSiteRequestWith:tabBarController.selectedIndex];
}
-(void)loadSiteRequestWith:(NSInteger)index
{
    SiteLogRequest *request = [SiteLogRequest new];
    request.type=[NSString stringWithFormat:@"%d",index+1];
    [appClient doSiteLog:request success:^(CGResponse *data, NSString *url) {
    }];
}
-(void)setTabVCWith:(NSInteger)index
{
    self.viewController.selectedIndex=index;
}
-(void)setTabNumWith:(NSString *)num
{
    NSInteger index=0;
    for (TabBarItem *item in [[self.viewController tabBar] items]) {
        if (index==3) {
            if (self.labNum==nil) {
                self.labNum=[[UILabel alloc]initWithFrame:CGRectMake(item.frame.size.width*0.55, 2, 18, 18)];
                self.labNum.layer.cornerRadius=9;
                self.labNum.layer.masksToBounds=YES;
                [self.labNum setTextAlignment:NSTextAlignmentCenter];
                [self.labNum setBackgroundColor:[UIColor redColor]];
                [self.labNum setTextColor:WHITE_COLOR];
                [self.labNum setFont:[UIFont LightFontOfSize:13]];
                [item addSubview:self.labNum];
            }
            if (num.intValue>0) {
                [self.labNum setHidden:NO];
                [self.labNum setText:(num.intValue>99) ? @"99+" : num];
                if (num.intValue>99) {
                    [self.labNum setFrame:CGRectMake(item.frame.size.width*0.55, 2, 25, 18)];
                }else{
                    [self.labNum setFrame:CGRectMake(item.frame.size.width*0.55, 2, 18, 18)];
                }
            }else{
                [self.labNum setHidden:YES];
            }
        }
        index++;
    }
}
- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = nil;

    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_8_4) {
        textAttributes = @{
                NSFontAttributeName : [UIFont LightFontOfSize:18],
                NSForegroundColorAttributeName : [UIColor whiteColor],
        };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
         textAttributes = @{
                            UITextAttributeFont: [UIFont LightFontOfSize:18],
                            UITextAttributeTextColor: [UIColor whiteColor],
                            UITextAttributeTextShadowColor: [UIColor clearColor],
                            UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                            };
#endif
    }
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}
#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"insuny" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"insuny.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}


- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {

}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int) response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse *sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse *) response;
        NSString *accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken) {
            self.wbtoken = accessToken;
        }
        NSString *userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int) response.statusCode, [(WBAuthorizeResponse *) response userID], [(WBAuthorizeResponse *) response accessToken], NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];

        self.wbtoken = [(WBAuthorizeResponse *) response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *) response userID];
        [alert show];
    }
    else if ([response isKindOfClass:WBPaymentResponse.class]) {
        NSString *title = NSLocalizedString(@"支付结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int) response.statusCode, [(WBPaymentResponse *) response payStatusCode], [(WBPaymentResponse *) response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSString *string = [url absoluteString];

    if ([string hasPrefix:@"tencent"]) {
        return [TencentOAuth HandleOpenURL:url];
    }
    else if ([string hasPrefix:@"wx"]) {
        if ([string containsString:@"pay"]) {
            return [WXApi handleOpenURL:url delegate:self.delegate_wx];            
        }else{
            return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication  annotation:annotation wxDelegate:self];
        }
    }
    else if ([string hasPrefix:@"ali"]) {

        if ([url.host isEqualToString:@"safepay"]) {

            [[AlipaySDK defaultService] processAuth_V2Result:url
                                             standbyCallback:^(NSDictionary *resultDic) {
                                                 NSLog(@"result = %@", resultDic);
                                                 NSString *resultStr = resultDic[@"result"];
                                                 NSLog(@"result = %@", resultStr);
                                             }];
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                      standbyCallback:^(NSDictionary *resultDic) {
                                                          NSLog(@"result = %@", resultDic);
                                                          NSString *resultStr = resultDic[@"result"];
                                                          NSLog(@"result = %@", resultStr);
                                                      }];

        }
        return YES;

    }
    else if ([string hasPrefix:@"wb"]) {
        return [WeiboSDK handleOpenURL:url delegate:self.delegate_weibo];
    }
    return [ShareSDK handleOpenURL:url  sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSString *string = [url absoluteString];

    if ([string hasPrefix:@"tencent"]) {
        return [TencentOAuth HandleOpenURL:url];
    }
    else if ([string hasPrefix:@"wx"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    return [WeiboSDK handleOpenURL:url delegate:self.delegate_weibo];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [UMessageHelper registerDeviceToken:deviceToken];
    [App shared].deviceToken = [self getDeviceTokenWith:deviceToken];
    [[App shared] saveDeviceToken];
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessageHelper didReceiveRemoteNotification:userInfo];
    NSString *alert=userInfo[@"aps"][@"alert"];
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:userInfo];
    }
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        [UIAlertView_Extend showAlertWithTiTle:@"吃几顿" message:alert cancelButtonTitle:nil otherButtonTitles:@[@"OK"] withCompletionBlock:^(NSInteger index) {
            NSLog(@"%@",alert);
        } andCancelBlock:^{
        } ];
    }
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self checkVersion];
}

- (NSString *)getDeviceTokenWith:(NSData *)data
{
    return [[[[data description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
             stringByReplacingOccurrencesOfString: @">" withString: @""]
            stringByReplacingOccurrencesOfString: @" " withString: @""];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userInfoNotification" object:self userInfo:userInfo];
    [UMessageHelper setAutoAlert:NO];
    [UMessageHelper didReceiveRemoteNotification:userInfo];
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(void)checkVersion
{
    appClient = [[CGClient alloc]
                      init:^(CGRequest *data, NSString *url, BOOL hideProgress) {
                      }
                      afterRequest:^(CGResponse *data, NSString *url) {
                      }
                      getToken:^NSString * {
                          return nil;
                      }
                      getApiUrl:^NSString * {
                          return [NSString stringWithFormat:@"%@/", API_URL];
                      }];
    StartUpIndexRequest *request = [StartUpIndexRequest new];
    request.version=Current_Version;
    [appClient doStartUpIndex:request success:^(CGResponse *data, NSString *url) {
        NSString *version=data.data[@"versionUpdateTime"];        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *oldVersion=[defaults objectForKey:@"versionUpdateTime"];
        
        if (![oldVersion isEqualToString:version]) {
            [defaults setObject:version forKey:@"versionUpdateTime"];
            [self updateApp];
        }else{
            NSData *dataVersion=[defaults objectForKey:@"versionTable"];
            VersionTable *versionTable = [NSKeyedUnarchiver unarchiveObjectWithData:dataVersion];
            if (versionTable) {
                [self showAlertWith:versionTable];
            }
            self.window.rootViewController = self.viewController;
        }
    }failure:^(CGResponse *data, NSString *url){
        self.window.rootViewController = self.viewController;
    }];
}
-(void)updateApp
{
    StartUpVersionRequest *request = [StartUpVersionRequest new];
    request.version=Current_Version;
    [appClient doStartUpVersion:request success:^(CGResponse *data, NSString *url) {
        StartUpVersionResponse *response=[[StartUpVersionResponse alloc]initWithCGResponse:data];
        [self showAlertWith:response.data];
        
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        NSData *dataVersion = [NSKeyedArchiver archivedDataWithRootObject:response.data];
        [userDefaultes setObject:dataVersion forKey:@"versionTable"];
        
        if ([response.data.show_type isEqualToString:@"startup_img"]) {
            ADViewController *adVC=[[ADViewController alloc]init];
            adVC.version=response.data;
            self.window.rootViewController=adVC;
            adVC.clickAdBlock=^(){
                self.window.rootViewController = self.viewController;
            };
            NSString *time=response.data.show_time;
            if (time.intValue==0) {
                time=@"2";
            }
            [self performSelector:@selector(removeAdImageView) withObject:nil afterDelay:time.intValue];
        }
        if ([response.data.show_type isEqualToString:@"startup_default_img"]) {
            self.window.rootViewController = self.viewController;
        }
        
    }];
}
- (void)removeAdImageView
{
    [UIView animateWithDuration:0.3f animations:^{
    } completion:^(BOOL finished) {
        self.window.rootViewController = self.viewController;
    }];
}
-(void)showAlertWith:(VersionTable *)version
{
    if (version.force.intValue==1) {
        [UIAlertView_Extend showAlertWithTiTle:version.title message:version.content cancelButtonTitle:nil otherButtonTitles:@[@"升级"] withCompletionBlock:^(NSInteger index) {
            
        } andCancelBlock:^{
            NSString *url=@"https://itunes.apple.com/us/app/chi-ji-dun/id1035516048?l=zh&ls=1&mt=8";
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
        } ];
    }
    if (version.force.intValue==2) {
        [UIAlertView_Extend showAlertWithTiTle:version.title message:version.content cancelButtonTitle:@"取消" otherButtonTitles:@[@"升级"] withCompletionBlock:^(NSInteger index) {
            NSString *url=@"https://itunes.apple.com/us/app/chi-ji-dun/id1035516048?l=zh&ls=1&mt=8";
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
        } andCancelBlock:^{
        } ];
    }
}

@end










