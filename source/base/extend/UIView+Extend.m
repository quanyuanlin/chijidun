//
//  UIView+Extend.m
//  chijidun
//
//  Created by iMac on 16/8/27.
//
//

#import "UIView+Extend.h"


@implementation UIView (Extend)


-(void)showHudWith:(NSString *)title
{
    UIImageView *backView=[[UIImageView alloc]initWithFrame:self.bounds];
    [backView setImage:[UIImage imageNamed:@"login_warnback"]];
    [self addSubview:backView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    [label setCenter:CGPointMake(kMainScreen_Width*0.5, kMainScreen_Height*0.4)];
    [label.layer setBackgroundColor:WHITE_COLOR.CGColor];
    label.layer.cornerRadius=5.0f;
    [label setTextColor:getUIColor(0xff5436)];
    [label setText:title];
    [label setTextAlignment:NSTextAlignmentCenter];
    [backView addSubview:label];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [backView removeFromSuperview];
    });
}

- (void)showHUD:(NSString *)title {
    [self showHUD:title callback:nil];
}

- (void)showHUD:(NSString *)title callback:(MBProgressHUDCompletionBlock)callback {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.labelText = title;
    hud.labelFont =[UIFont LightFontOfSize:15];
    hud.mode = MBProgressHUDModeCustomView;
    [self addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1];
    hud.completionBlock = callback;
}

-(void)showHUDDesc:(NSString *)desc
{
    [self showHUDDesc:desc callback:nil];
}
- (void)showHUDDesc:(NSString *)desc callback:(MBProgressHUDCompletionBlock)callback {
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.detailsLabelFont=[UIFont LightFontOfSize:15];
    hud.detailsLabelText = desc;
    hud.mode = MBProgressHUDModeCustomView;
    [self addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:1];
    hud.completionBlock = callback;
}

- (void)click:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:action]];
}


@end







