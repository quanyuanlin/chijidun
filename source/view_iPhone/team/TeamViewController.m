 //
//  TeamViewController.m
//  chijidun
//
//  Created by iMac on 16/8/30.
//
//

#import "TeamViewController.h"
NSString *const PaySuccessNotification = @"PaySuccessNotification";

@interface TeamViewController ()
{
    UIWebView *m_webView;    
    UIView *m_statusView;
    
    TabBarController *tabVC;
    NSString *_payway;
    
    MBProgressHUD *_hud;
}
@end

@implementation TeamViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    if (_isHome) {
        [m_webView stringByEvaluatingJavaScriptFromString:@"h5.onResume();"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [UIView setAnimationsEnabled:NO];
    
    UINavigationController *navi=[[UINavigationController alloc]init];
    navi=(UINavigationController *)self.parentViewController;
    tabVC=(TabBarController *)navi.parentViewController;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    m_statusView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 20)];
    [m_statusView setBackgroundColor:MAIN_COLOR];
    [self.view addSubview:m_statusView];
    
    CGFloat height=kMainScreen_Height-20;
    if (self.url.length==0) {
        //self.url=kTeamOrderUrl;
        height=kMainScreen_Height-NAV_HEIGHT;
    }

    m_webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 20, kMainScreen_Width, height)];
    [self.view addSubview:m_webView];
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    m_webView.delegate = self;
    m_webView.scrollView.bounces=NO;
    [m_webView loadRequest:request];
    
    self.jsContext = [m_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"chijidun"]=self;

    //注册通知
    [[NSNotificationCenter defaultCenter]addObserverForName:@"loginSuccess" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
        [m_webView stringByEvaluatingJavaScriptFromString:@"h5.loginSuccess();"];
    }];
    
    [[NSNotificationCenter defaultCenter]addObserverForName:@"loginOut" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
        [m_webView stringByEvaluatingJavaScriptFromString:@"h5.loginOut();"];
    }];
    [[NSNotificationCenter defaultCenter]addObserverForName:PaySuccessNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
        NSMutableString *js = [NSMutableString string];
        [js appendString:[NSString stringWithFormat:@"h5.payCallback('%@','%@');", note.userInfo[@"errCode"],note.userInfo[@"payway"]]];
        [m_webView stringByEvaluatingJavaScriptFromString:js];

    }];
    
    
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    delegate.delegate_wx = self;    
}

//webview加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"chijidun"]=self;
    [m_webView stringByEvaluatingJavaScriptFromString:@"iosRadio.init();"];
    
}

//delegate
-(void)setStatubarColor:(NSString *)color
{
    [m_statusView setBackgroundColor:[self hexStringToColor:color]];
    if ([color isEqualToString:@"#f8f8f8"]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

-(void)showDialog:(NSString *)context
{    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (context!=nil) {
            if (_hud==nil) {
                _hud = [[MBProgressHUD alloc] initWithView:self.view];
                _hud.mode = MBProgressHUDModeCustomView;
                [self.view addSubview:_hud];
            }
            if (context.length>0) {
                _hud.labelText = context;
            }else{
                _hud.labelText = @"加载中";
            }
            [_hud show:YES];
        }
    });
    
    
}
-(void)dissmisDialog
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_hud hide:YES];
    });
} 
-(void)finish
{

}
-(void)gohome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    tabVC.tabBarHidden=NO;
    tabVC.selectedIndex=1;
}
-(void)openBlank:(NSString *)context
{
    TeamViewController *teamVC=[[TeamViewController alloc]init];
    teamVC.url=context;
    tabVC.tabBarHidden=YES;
    teamVC.isHome=NO;
    [self.navigationController pushViewController:teamVC animated:YES];
}
-(NSString *)getToken
{
    NSString *token=[App shared].currentUser.token;
    if (token==nil) {
        token=@"";
    }
    return token;
}
-(void)openLogin
{
    [self presentVC:[LoginViewController new]];
}

-(NSString *)getmDeviceToken
{
    NSString *deviceToken = [App shared].deviceToken;
    return deviceToken;
}
-(void)openActivity:(NSString *)context
{
    if ([context isEqualToString:@"com.chijidun.chi.remind.activity.GroupSetActivity"]) {
        TeamSetViewController *setVC=[[TeamSetViewController alloc]init];
        setVC.backBlock=^(){
            [m_webView stringByEvaluatingJavaScriptFromString:@"h5.onResume();"];
        };
        [self showNavigationView:setVC];
    }
}
-(void)aliPay:(NSString *)sign
{
    _payway=@"3";
    NSString *appScheme = @"alipaychi";
    [[AlipaySDK defaultService] payOrder:sign fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@", resultDic);
        BaseResp *br = [[BaseResp alloc] init];
        if ([resultDic[@"resultStatus"] intValue] == 6001) {
            br.errCode = -2;
        }
        else if ([resultDic[@"resultStatus"] intValue] == 9000) {
            br.errCode = 0;
        }
        else {
            br.errCode = -1;
        }
        [self onResp:br];
    }];
}
-(void)weixinPay:(NSString *)sign
{
    _payway=@"4";
    NSData *JSONData = [sign dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *response= [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    PayReq *request = [[PayReq alloc] init];
    request.openID = response[@"appid"];
    request.partnerId = response[@"partnerid"];
    request.prepayId = response[@"prepayid"];
    request.nonceStr = response[@"noncestr"];
    request.timeStamp = (UInt32) [response[@"timestamp"] intValue];
    request.package = response[@"package"];
    request.sign = response[@"sign"];
    [WXApi safeSendReq:request];
}
//微信支付
- (void)onResp:(BaseResp *)resp {
    
    NSString *_errorCode=@"1";
    if (resp.errCode == 0) {
        _errorCode=@"0";
    }else{
         _errorCode=@"1";
    }
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:_errorCode,@"errCode",_payway,@"payway", nil];
    NSNotification *notification =[NSNotification notificationWithName:PaySuccessNotification object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

//设置颜色
-(UIColor *)hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PaySuccessNotification object:nil];
}

@end







