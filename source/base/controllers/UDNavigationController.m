//
//  UDNavigationController.m
//  test
//
//  Created by UDi on 15-1-7.
//  Copyright (c) 2015年 Mango Media Network Co.,Ltd. All rights reserved.
//

#import "UDNavigationController.h"

@implementation UDNavigationController
@synthesize alphaView;
-(id)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        CGRect frame = self.navigationBar.frame;
        alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height+20)];
        alphaView.backgroundColor = MAIN_COLOR;
        
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
        [self.view insertSubview:alphaView belowSubview:self.navigationBar];

    }
    return self;
}
-(void)setAlph:(double)value{
    [UIView animateWithDuration:1.0 animations:^{
        alphaView.alpha = value;
    } completion:^(BOOL finished) {
        _changing = NO;
        
    }];
}

@end
