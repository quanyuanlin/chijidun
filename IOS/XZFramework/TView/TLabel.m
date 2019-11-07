//
//  GKLabel.m
//  btc
//
//  Created by txj on 15/1/25.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "TLabel.h"

@implementation UILabel(Strikethrough)

- (void)setStrikethrough
{
    NSMutableAttributedString *attribute;
    attribute = [[NSMutableAttributedString alloc]
                 initWithAttributedString:self.attributedText];
    NSNumber *strikethrough = [NSNumber numberWithInt:NSUnderlineStyleSingle];
    CGFloat length = self.text.length;
    [attribute addAttribute:NSStrikethroughStyleAttributeName
                      value:strikethrough range:NSMakeRange(0, length)];
    self.attributedText = attribute;
}
@end

#pragma mark VerticalAlign
@implementation UILabel(VerticalAlign)
-(void)alignTop {
    CGSize fontSize =[self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height *self.numberOfLines;
    double finalWidth =self.frame.size.width;//expected width of label
    CGSize theStringSize =[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad =(finalHeight - theStringSize.height)/ fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text =[self.text stringByAppendingString:@"\n "];
}

-(void)alignBottom {
    CGSize fontSize =[self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height *self.numberOfLines;
    double finalWidth =self.frame.size.width;//expected width of label
    CGSize theStringSize =[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad =(finalHeight - theStringSize.height)/ fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text =[NSString stringWithFormat:@" \n%@",self.text];
}
@end