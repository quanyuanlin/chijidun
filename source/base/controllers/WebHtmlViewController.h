//
//  WebHtmlViewController.h
//  
//
//  Created by iMac on 16/3/16.
//
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebHtmlViewController : TBaseUIViewController
<WKNavigationDelegate>
{
    NSString *title;//标题
    NSString *strurl;//链接
    BOOL mIsPopController;//是否重新弹出一个界面
}
@property (nonatomic, strong) WKWebView *webView;

-(instancetype)initWithTitle:(NSString *)stitle withUrl:(NSString *)url;
-(instancetype)initWithTitle:(NSString *)stitle withUrl:(NSString *)url popController:(BOOL)isPopController;

@end
