//
//  UITextField+Extend.m
//  chijidun
//
//  Created by iMac on 16/8/27.
//
//

#import "UITextField+Extend.h"

@implementation UITextField (Extend)

+(UITextField *)textFieldWithFrame:(CGRect)frame drawingLeft:(NSString *)icon {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 35)];
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 9, 16, 16)];
    [imgView setImage:[UIImage imageNamed:icon]];
    [leftView addSubview:imgView];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 34, frame.size.width, 1)];
    [line setBackgroundColor:WHITE_COLOR];
    [textField addSubview:line];
    [textField setTintColor:WHITE_COLOR];
    [textField setTextColor:WHITE_COLOR];
    
    return textField;
}
-(void)setPlaceholder:(NSString *)holder Corlor:(UIColor *)color
{
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:holder attributes:@{NSForegroundColorAttributeName: color}];
}

-(void)showDeleteView
{
    CGFloat X=CGRectGetMaxX(self.frame);
    CGFloat Y=self.frame.origin.y;
    UIImageView *errorView=[[UIImageView alloc]initWithFrame:CGRectMake(X, Y, 30, 27)];
    [errorView setImage:[UIImage imageNamed:@"login_delete"]];
    [errorView click:self action:@selector(clearContent:)];
    [self.superview addSubview:errorView];
}
-(void)clearContent:(id)sender
{
    [self clearsContextBeforeDrawing];
}
-(void)setLeftDistance:(CGFloat)height
{
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, height)];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}


@end





