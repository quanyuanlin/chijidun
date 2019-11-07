//
//  FindViewController.h
//  chijidun
//
//  Created by iMac on 16/10/26.
//
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "FindDetailViewController.h"

@protocol JSObjctDelegate <JSExport>

-(void)showDialog:(NSString *)context;
-(void)dissmisDialog;
-(void)openBlank:(NSString *)context;
-(NSString *)getAppVersionName;

@end
@interface FindViewController : TBaseUIViewController
<UIWebViewDelegate,JSObjctDelegate>

@property (nonatomic, strong) JSContext *jsContext;
@property(nonatomic,strong)NSString *url;


@end
