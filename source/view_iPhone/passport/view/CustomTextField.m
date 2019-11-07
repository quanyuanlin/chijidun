//
//  CustomTextField.m
//  chijidun
//
//  Created by iMac on 16/8/29.
//
//

#import "CustomTextField.h"

@implementation CustomTextField
- (id)initWithFrame:(CGRect)frame drawingLeft:(NSString *)icon {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, S(16), S(16))];
        [imgView setImage:[UIImage imageNamed:icon]];
        self.leftView = imgView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        UIButton *clearButton = [self valueForKey:@"_clearButton"];
        [clearButton setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateNormal];
        [clearButton setImage:[UIImage imageNamed:@"login_delete"] forState:UIControlStateHighlighted];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, S(49), frame.size.width-S(30), S(1))];
        [line setBackgroundColor:WHITE_COLOR];
        [self addSubview:line];
        //光标颜色
        [[self valueForKey:@"textInputTraits"] setValue:WHITE_COLOR forKey:@"insertionPointColor"];
        [self setTextColor:WHITE_COLOR];
    }
    return self;
}
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x, S(24), S(16), S(16));
}
-(CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + bounds.size.width - S(30)-_clearX, bounds.origin.y + bounds.size.height -S(32), S(30), S(27));
}
//控制placeHolder的位置
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+S(26), bounds.origin.y+S(7), bounds.size.width -S(56), S(20));
    return inset;
}
//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+S(26), bounds.origin.y+S(7), bounds.size.width -S(56), bounds.size.height);
    return inset;
}
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x +S(26), bounds.origin.y+S(7), bounds.size.width -S(56), bounds.size.height);
    return inset;
}

@end









