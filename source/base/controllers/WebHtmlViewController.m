//
//  WebHtmlViewController.m
//  
//
//  Created by iMac on 16/3/16.
//
//

#import "WebHtmlViewController.h"

@interface WebHtmlViewController ()

@end

@implementation WebHtmlViewController
-(instancetype)initWithTitle:(NSString *)stitle withUrl:(NSString *)url
{
    self=[super init];
    
    if (self) {
        self.title=stitle;
        strurl=url;
        mIsPopController=NO;
    }
    
    return self;
}
-(instancetype)initWithTitle:(NSString *)stitle withUrl:(NSString *)url popController:(BOOL)isPopController
{
    self=[super init];
    
    if (self) {
        self.title=stitle;
        strurl=url;
        mIsPopController=isPopController;
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //阻止视频继续播放
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    
    WKWebViewConfiguration *configuration=[WKWebViewConfiguration new];
    configuration.allowsInlineMediaPlayback=YES;
    configuration.mediaPlaybackAllowsAirPlay=YES;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    NSURL *url =[NSURL URLWithString:strurl];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.webView loadRequest:request];
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"%@", webView.URL.absoluteString);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
    NSURL *url = navigationAction.request.URL;
    if ([[url.absoluteString lowercaseString] isEqualToString:@"about:blank"]) {
        return;
    }
    if ([url.host isEqualToString:@"v.qq.com"]) {
        return;
    }
    if ([[NSString stringWithFormat:@"%@", url] isEqualToString:strurl]) {
        return;
    }
    UIApplication *app = [UIApplication sharedApplication];
    
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}

@end






