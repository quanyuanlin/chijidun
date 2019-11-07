//
//  ChefWarnView.m
//  chijidun
//
//  Created by iMac on 16/11/1.
//
//

#import "ChefWarnView.h"

#define Icon_Size   15
#define Delete_Size 18

@interface ChefWarnView ()
{
   
}
@end
@implementation ChefWarnView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviewsWith:frame];
    }
    return self;
}
-(void)addSubviewsWith:(CGRect)frame
{
    UIImageView *back=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [back setUserInteractionEnabled:YES];
    [back setImage:[UIImage imageNamed:@"chef_warn"]];
    [self addSubview:back];
    
    UIImageView *iconView=[[UIImageView alloc]initWithFrame:CGRectMake(kDistanceMin, 25/2, Icon_Size, Icon_Size)];
    [iconView setImage:[UIImage imageNamed:@"chef_icon"]];
    [back addSubview:iconView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame)+5, kDistanceMin, W(back)-80, 20)];
    [label setTextColor:WHITE_COLOR];
    [label setFont:[UIFont LightFontOfSize:14]];
    [label setText:@"温馨提示：可以在购物车里添加米饭哦"];
    [back addSubview:label];
    
    UIButton *deleteBtn=[[UIButton alloc]initWithFrame:CGRectMake(W(back)-40-4, 0, 40, 40)];
    [deleteBtn setImageEdgeInsets:UIEdgeInsetsMake(11, 11, 11, 11)];
    [deleteBtn setImage:[UIImage imageNamed:@"chef_delete"] forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"chef_delete"] forState:UIControlStateHighlighted];
    [deleteBtn addTarget:self action:@selector(removeView:) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:deleteBtn];
}
-(void)removeView:(UIButton *)button
{
    self.removeBlock(YES);
    [self removeFromSuperview];
}
@end
