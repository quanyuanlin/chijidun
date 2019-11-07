//
//  Share.h
//  MaoChao
//
//  Created by Jerry on 15/2/10.
//  Copyright (c) 2015年 Suzhou Xiaolingmao Information Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "MBProgressHUD+MJ.h"
#import "ChefDetailVC.h"
#import "codeView.h"
@interface Share : NSObject

/**
 *  分享不能编辑的内容
 *
 *  @param title          标题
 *  @param content        长文本 140字以内
 *  @param url            可以跳转的URL
 *  @param iconUrl        分享的图片链接 (sina微博分享失败)
 *  @param iconPath       分享的图片本地路径
 *  @param viewController 自定义分享界面的代理
 */
+ (void)showShareMenuWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url iconUrl:(NSString *)iconUrl iconPath:(NSString *)iconPath inView:(UIViewController<ISSViewDelegate,ISSShareViewDelegate> *)viewController;


@end
