//
//  FindDetailViewController.h
//  chijidun
//
//  Created by iMac on 16/11/2.
//
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "ChefDetailVC.h"
#import "DiscoveryShare.h"

@protocol JSDelegate <JSExport>

-(void)showDialog:(NSString *)context;
-(void)dissmisDialog;
-(void)openActivity:(NSString *)context;
-(void)privateKitchen:(NSString *)chefId;
-(NSString *)getAppVersionName;

@end
@interface FindDetailViewController : TBaseUIViewController
<UIWebViewDelegate,JSDelegate,ISSViewDelegate,ISSShareViewDelegate>

@property (nonatomic, strong) JSContext *jsContext;
@property(nonatomic,strong)NSString *url;

@property BOOL isHome;
@property (nonatomic, strong)Ad_appTable *adTable;

@property (nonatomic, strong)NSDictionary *responseJSON;

@end
