//
//  FindViewController.m
//  chijidun
//
//  Created by iMac on 16/10/26.
//
//

#import "FindViewController.h"

@interface FindViewController ()
{
    UIWebView *m_webView;
}
@end

@implementation FindViewController
- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发现";
    
    CGFloat height=kMainScreen_Height-50-NAV_HEIGHT+1;
    m_webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, height)];
    [self.view addSubview:m_webView];
    
    self.url=kFindUrl;
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    m_webView.delegate = self;
    m_webView.scrollView.bounces=NO;
    [m_webView loadRequest:request];
    
    self.jsContext = [m_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"chijidun"]=self;
}
//webview加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"chijidun"]=self;
    [m_webView stringByEvaluatingJavaScriptFromString:@"iosRadio.init();"];
    
}
-(void)showDialog:(NSString *)context
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (context!=nil) {
            
            if (context.length>0) {
                progressbar.labelText = context;
            }else{
                progressbar.labelText = @"加载中";
            }
            [progressbar show:YES];
        }
    });
}
-(void)dissmisDialog
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [progressbar hide:YES];
    });
}
-(NSString *)getAppVersionName
{
    NSString *version = Current_Version;
    return version;
}
-(void)openBlank:(NSString *)context
{
    NSData *JSONData = [context dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    
    FindDetailViewController *detail=[[FindDetailViewController alloc]init];
    detail.responseJSON=responseJSON;
    [self showNavigationView:detail];
}


@end
