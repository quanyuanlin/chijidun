//
//  DiscoveryShare.m
//  chijidun
//
//  Created by iMac on 16/11/7.
//
//

#import "DiscoveryShare.h"
#import <ShareSDK/ShareSDK.h>
#import "AppDelegate.h"

@implementation DiscoveryShare

#pragma mark 分享
+ (void)showShareMenuWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url iconUrl:(NSString *)iconUrl iconPath:(NSString *)iconPath inView:(UIViewController<ISSViewDelegate,ISSShareViewDelegate> *)viewController {
    void(^doShareBlock)(ShareType) = ^(ShareType shareType){
        
        // 图片
        id <ISSCAttachment> shareImage = nil;
        if (iconUrl.length > 0){
            shareImage = [ShareSDK imageWithUrl:iconUrl];
        }
        else if(iconPath.length > 0){
            shareImage = [ShareSDK imageWithPath:iconPath];
        }
        
        
        NSString *strContent = [NSString stringWithFormat:@"%@@吃几顿%@", content, url];
        
        //构造分享内容
        id <ISSContent> publishContent = [ShareSDK content:strContent
                                            defaultContent:@""
                                                     image:shareImage
                                                     title:title
                                                       url:url
                                               description:content
                                                 mediaType:SSPublishContentMediaTypeNews];
        
        // 微信朋友圈
        [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
                                              content:content
                                                title:title
                                                  url:url
                                           thumbImage:shareImage
                                                image:shareImage
                                         musicFileUrl:nil
                                              extInfo:nil
                                             fileData:nil
                                         emoticonData:nil];
        //定制微信朋友圈
        [publishContent addWeixinSessionUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
                                             content:content
                                               title:title
                                                 url:url
                                          thumbImage:shareImage
                                               image:shareImage
                                        musicFileUrl:nil
                                             extInfo:nil
                                            fileData:nil
                                        emoticonData:nil];
        
        
        //定制QQ分享信息
        [publishContent addQQUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
                                  content:content
                                    title:title
                                      url:url
                                    image:shareImage];
        
        //定制微博信息
        //[publishContent addSinaWeiboUnitWithContent:strContent image:nil];
        
        
        
        //定义容器
        id <ISSContainer> container = [ShareSDK container];
        [container setIPhoneContainerWithViewController:viewController];
        
        id <ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                              allowCallback:NO
                                                              authViewStyle:SSAuthViewStyleFullScreenPopup
                                                               viewDelegate:nil
                                                    authManagerViewDelegate:viewController];
        
        id <ISSShareOptions> shareOptions = [ShareSDK appRecommendShareOptionsWithTile:@"内容分享"
                                                                     shareViewDelegate:viewController];
        [shareOptions setShowKeyboardOnAppear:NO];
        
        [ShareSDK shareContent:publishContent
                          type:shareType  // 只对参数类型的平台进型发布
                   authOptions:authOptions
                  shareOptions:shareOptions
                 statusBarTips:NO
                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                            if (type==ShareTypeSinaWeibo) {
                                if (end) {
                                    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
                                    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
                                    authRequest.redirectURI = kRedirectURI;
                                    authRequest.scope = @"all";
                                    
                                    WBMessageObject *message = [WBMessageObject message];
                                    message.text = strContent;
                                    
                                    UIGraphicsBeginImageContext(viewController.view.frame.size);
                                    CGContextRef context = UIGraphicsGetCurrentContext();
                                    [viewController.view.layer renderInContext:context];
                                    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
                                    UIGraphicsEndImageContext();
                                    NSData *imageData = UIImagePNGRepresentation(img);
                                    WBImageObject *image = [WBImageObject object];
                                    image.imageData=[NSData dataWithData:imageData];
                                    message.imageObject = image;
                                    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:myDelegate.wbtoken];
                                    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                                                         @"Other_Info_1": [NSNumber numberWithInt:123],
                                                         @"Other_Info_2": @[@"obj1", @"obj2"],
                                                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
                                    [WeiboSDK sendRequest:request];
                                     }
                            }else {
                                if (state == SSResponseStateSuccess) {
                                    NSString *strOK = @"分享成功";
                                    [MBProgressHUD showSuccess:strOK];
                                }else if (state == SSPublishContentStateFail) {
                                    if (type==24&&![TencentOAuth iphoneQQInstalled]) {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"                                                                                    message:@"没有安装QQ" delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil,nil];
                                        [alert show];
                                    }else if ((type==22||type==23)&&![WXApi isWXAppInstalled]) {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"  message:@"没有安装微信" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
                                        [alert show];
                                    }
                                }else if (state==SSResponseStateFail){
                                    [MBProgressHUD showError:@"分享失败"];
                                }
                            }
                        }];
        
    };
    
    
    
    id<ISSShareActionSheetItem> sinaItem = [ShareSDK shareActionSheetItemWithTitle:@"微博"
                                                                              icon:[UIImage imageNamed:@"share_weibo"]
                                                                      clickHandler:^{
                                                                          doShareBlock(ShareTypeSinaWeibo);
                                                                      }];
    
    
    id<ISSShareActionSheetItem> qqItem = [ShareSDK shareActionSheetItemWithTitle:@"QQ"
                                                                            icon:[UIImage imageNamed:@"share_qq"]
                                                                    clickHandler:^{
                                                                        doShareBlock(ShareTypeQQ);
                                                                    }];
    
    
    
    id<ISSShareActionSheetItem> weixinItem = [ShareSDK shareActionSheetItemWithTitle:@"微信"
                                                                                icon:[UIImage imageNamed:@"share_weixin"]
                                                                        clickHandler:^{
                                                                            doShareBlock(ShareTypeWeixiSession);
                                                                        }];
    
    id<ISSShareActionSheetItem> pyqItem = [ShareSDK shareActionSheetItemWithTitle:@"微信朋友圈"
                                                                             icon:[UIImage imageNamed:@"share_pyq"]
                                                                     clickHandler:^{
                                                                         doShareBlock(ShareTypeWeixiTimeline);
                                                                     }];
    
    NSArray *shareList = [ShareSDK customShareListWithType:
                          weixinItem,
                          pyqItem,
                          qqItem,
                          sinaItem,
                          nil];
    
    // 显示菜单, 实际处理, 都在每一个item 的回调里
    [ShareSDK showShareActionSheet:INHERIT_VALUE
                         shareList:shareList
                           content:INHERIT_VALUE
                     statusBarTips:NO
                       authOptions:nil
                      shareOptions:INHERIT_VALUE
                            result:nil];
    
}


@end
