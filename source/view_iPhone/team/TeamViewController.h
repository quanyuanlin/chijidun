//
//  TeamViewController.h
//  chijidun
//
//  Created by iMac on 16/8/30.
//
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "TeamSetViewController.h"
#import "LoginViewController.h"

#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@protocol JSObjcDelegate <JSExport>

- (void)setStatubarColor:(NSString *)color;
-(void)showDialog:(NSString *)context;
-(void)dissmisDialog;
-(void)finish;
-(void)gohome;
-(void)openBlank:(NSString *)context;

-(NSString *)getToken;
-(void)openLogin;

-(NSString *)getmDeviceToken;
-(void)openActivity:(NSString *)context;

-(void)aliPay:(NSString *)sign;
-(void)weixinPay:(NSString *)sign;

@end

@interface TeamViewController : TBaseUIViewController
<UIWebViewDelegate,JSObjcDelegate,WXApiDelegate>

@property (nonatomic, strong) JSContext *jsContext;
@property(nonatomic,strong)NSString *url;

@property BOOL isHome;

@end




