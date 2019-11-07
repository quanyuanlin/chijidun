//
//  ADViewController.h
//  
//
//  Created by iMac on 16/1/27.
//
//

#import <UIKit/UIKit.h>
#import "WebHtmlViewController.h"
@interface ADViewController : TBaseUIViewController

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong) VersionTable *version;
@property(nonatomic,strong) void(^clickAdBlock)();

@end
