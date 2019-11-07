//
//  UIAlertView+Extend.m
//  
//
//  Created by iMac on 15/12/14.
//
//

#import "UIAlertView+Extend.h"

@implementation UIAlertView_Extend

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            // Initialization code
    }
    return self;
}


+ (void)showAlertWithTiTle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *) cancelButtonTitle otherButtonTitles:(NSArray *)buttonTitles withCompletionBlock:(AlertCompletionBlock)completionblock andCancelBlock:(AlertCancelBlock)cancelBlock
{
    UIAlertView_Extend *alertView = [[UIAlertView_Extend alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    
    alertView.completionBlock = completionblock;
    alertView.cancelBlock = cancelBlock;
    alertView.delegate = alertView;
    
    if (alertView)
    {
        for (NSString *buttonTitle in buttonTitles)
        {
            [alertView addButtonWithTitle:buttonTitle];
        }

    }
    
    [alertView show];
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (_cancelBlock)
        {
            _cancelBlock();
        }
    }
    else
    {
        _completionBlock(buttonIndex);
    }
}


@end




