//
//  ChefStoryView.m
//  
//
//  Created by iMac on 16/1/26.
//
//

#import "ChefStoryView.h"
#define Distance 40
@interface ChefStoryView ()
{
    UIView *m_backView;
    
    UIButton *m_closeBtn;
    UILabel *m_labStory;
}
@end
@implementation ChefStoryView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews
{
    m_backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
    m_backView.backgroundColor=[UIColor blackColor];
    m_backView.alpha=0.6f;
    [self addSubview:m_backView];
    
    
    m_closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(kMainScreen_Width-55, 52, 20, 20)];
    //m_closeBtn.center=CGPointMake(kMainScreen_Width-40, 40);
    [m_closeBtn setImage:[UIImage imageNamed:@"chef_closeStory"] forState:UIControlStateNormal];
    [m_closeBtn addTarget:self action:@selector(closeStoryView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:m_closeBtn];
    
    CGFloat centerY=kMainScreen_Height*0.18;
    
    UILabel *labTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    [labTitle setTextColor:WHITE_COLOR];
    [labTitle setText:@"私厨故事"];
    [labTitle setFont:[UIFont BoldFontOfSize:20]];
    labTitle.center=CGPointMake(kMainScreen_Width*0.5, centerY);
    [self addSubview:labTitle];
    
    [self.layer addSublayer:getLine(CGRectGetMinX(labTitle.frame)-50, CGRectGetMinX(labTitle.frame)-10, centerY, centerY, WHITE_COLOR)];
    [self.layer addSublayer:getLine(CGRectGetMaxX(labTitle.frame)+10, CGRectGetMaxX(labTitle.frame)+50, centerY, centerY, WHITE_COLOR)];
    
    UITapGestureRecognizer *tapView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeStoryView:)];
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:tapView];
}
-(void)closeStoryView:(id)sender
{
    [self removeFromSuperview];
}
-(void)SetStory:(NSString *)story
{
    m_labStory=[[UILabel alloc]initWithFrame:CGRectMake(Distance, kMainScreen_Height*0.18+30, kMainScreen_Width-Distance*2, getTextHeight(story, kMainScreen_Width-Distance*2, [UIFont BoldFontOfSize:17]))];
    [m_labStory setNumberOfLines:0];
    [m_labStory setTextColor:WHITE_COLOR];
    [m_labStory setFont:[UIFont BoldFontOfSize:17]];
    [m_labStory setText:story];
    [self addSubview:m_labStory];
    
}



@end







