//
//  GuideVC.h
//  JieFangShop2.0
//
//  Created by Apple on 15/4/27.
//  Copyright (c) 2015年 yuanlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideVC : UIViewController
<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIPageControl *pageControl;

@property (nonatomic,strong) void(^clickBlock)();

@end
