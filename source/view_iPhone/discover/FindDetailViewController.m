//
//  FindDetailViewController.m
//  chijidun
//
//  Created by iMac on 16/11/2.
//
//

#import "FindDetailViewController.h"

@interface FindDetailViewController ()
{
    UIWebView *m_webView;
    
    // 分享功能 辅助参数
    UIImageView *_ivShareImage;
    NSString *_strShareContent;
    NSString *_strShareTitle;
    NSString *_strShareUrl;
    NSString *_strShareImageLocalPath;
    
    UIButton *m_rightBtn;
}
@end

@implementation FindDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_isHome) {
        self.url=self.adTable.link_url;
        self.title=self.adTable.title;
    }else{
        self.url=_responseJSON[@"url"];
        self.title=_responseJSON[@"title"];
    }
    
    
    [self setNavigationBar];
    
    CGFloat height=kMainScreen_Height-NAV_HEIGHT;
    m_webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, height)];
    [self.view addSubview:m_webView];
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    m_webView.delegate = self;
    m_webView.scrollView.bounces=NO;
    [m_webView loadRequest:request];
    
    self.jsContext = [m_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"chijidun"]=self;  
}
-(void)setNavigationBar
{
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(-30, 0, 60, 44)];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(-10, 0, 34, 44);
    [backBtn setImage:[UIImage imageNamed:@"icon-back-left"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(14, 10, 14, 10)];
    [leftView addSubview:backBtn];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(backBtn.frame)+5, 12, 20, 20)];
    [button setImage:[UIImage imageNamed:@"share_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:button];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem=backItem;
    
    m_rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [m_rightBtn setImage:[UIImage imageNamed:@"share_chef"] forState:UIControlStateNormal];
    [m_rightBtn addTarget:self action:@selector(shareChef:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:m_rightBtn];
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
- (void)shareChef:(UIButton *)button
{
    int sinaMaxTextLen = 140;
    if (_isHome) {
        _strShareTitle=_adTable.share_title;
        _strShareContent=_adTable.share_desc;
    }else{
        _strShareTitle=_responseJSON[@"shareTitle"];
        _strShareContent=_responseJSON[@"shareText"];
    }
    NSString *_shareContent = _strShareContent;
    if (_shareContent.length > sinaMaxTextLen) {
        _shareContent = [[_strShareContent substringToIndex:sinaMaxTextLen - 5] stringByAppendingString:@"..."];
    }
    if (_isHome) {
        _strShareUrl=_adTable.share_url;
        _strShareImageLocalPath=_adTable.share_icon;
    }else{
        _strShareUrl=_responseJSON[@"shareUrl"];
        _strShareImageLocalPath=_responseJSON[@"imageUrl"];
    }
    [DiscoveryShare showShareMenuWithTitle:_strShareTitle
                          content:_shareContent
                              url:_strShareUrl
                          iconUrl:_strShareImageLocalPath
                         iconPath:nil
                           inView:self];
}
-(void)privateKitchen:(NSString *)chefId
{
    if (chefId.length>0) {
        ChefDetailVC *detailVC = [ChefDetailVC new];
        detailVC.Id = chefId;
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:detailVC];
        [self presentViewController:navigationController animated:NO completion:^{
        }];
    }
}
@end
