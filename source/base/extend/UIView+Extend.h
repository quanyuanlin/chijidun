//
//  UIView+Extend.h
//  chijidun
//
//  Created by iMac on 16/8/27.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Extend)

-(void)showHudWith:(NSString *)title;

- (void)showHUD:(NSString *)title;

- (void)showHUD:(NSString *)title callback:(MBProgressHUDCompletionBlock)callback;

-(void)showHUDDesc:(NSString *)desc;

- (void)showHUDDesc:(NSString *)desc callback:(MBProgressHUDCompletionBlock)callback ;

- (void)click:(id)target action:(SEL)action;

@end
