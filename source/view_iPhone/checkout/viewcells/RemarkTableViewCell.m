//
//  RemarkTableViewCell.m
//  insuny
//
//  Created by iMac on 15/8/22.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "RemarkTableViewCell.h"
@interface RemarkTableViewCell()
{
    //CheckoutViewController *checkView;
}
@end
@implementation RemarkTableViewCell
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect cellRect = self.frame;
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, cellRect.size.width, cellRect.size.height));
    [self setSubViews];
}
-(void)setSubViews
{
    [self.lineLabel setBackgroundColor:COLOR_LIGHT_GRAY];
    [self.smallLabel setTextColor:COLOR_LIGHT_GRAY];
    [self.remarkTextView setTextColor:COLOR_DEEP_GRAY];
    self.remarkTextView.delegate=self;
    self.remarkTextView.returnKeyType=UIReturnKeyDone;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.smallLabel setHidden:YES];
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        [self.smallLabel setHidden:NO];
    }
}
-(void)textViewDidChange:(UITextView *)textView
{    
    if ([_delegate respondsToSelector:@selector(textViewDidEndWith:)]) {
        [_delegate textViewDidEndWith:textView.text];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


@end





