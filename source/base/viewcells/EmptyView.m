//
//  EmptyView.m
//  
//
//  Created by iMac on 15/12/11.
//
//

#import "EmptyView.h"
#define IMG_WIDTH 90
#define IMG_HEIGHT 121

#define EMPTY_WIDTH S(120)
#define EMPTY_HEIGHT S(150)
@interface EmptyView()
{
    UIImageView *m_imgView;
    UILabel *m_labTitle;
    UILabel *m_labSubTitle;
    
    UIButton *m_button;
}
@end
@implementation EmptyView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviewsWith:frame];
    }
    return self;
}
-(void)addSubviewsWith:(CGRect)frame
{
    [self setBackgroundColor:getUIColor(0xffffff)];
    CGSize sizeView=frame.size;
    
    m_imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IMG_WIDTH, IMG_HEIGHT)];
    m_imgView.center=CGPointMake(sizeView.width*0.5, S(50)+IMG_HEIGHT/2);
    [self addSubview:m_imgView];
    
    m_labTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, sizeView.width*0.8, kCellHeight)];
    [m_labTitle setTextColor:getUIColor(0x999999)];
    [m_labTitle setFont:[UIFont LightFontOfSize:15]];
    m_labTitle.center=CGPointMake(sizeView.width*0.5, CGRectGetMaxY(m_imgView.frame)+kCellHeight);
    [m_labTitle setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:m_labTitle];
    
    m_labSubTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, sizeView.width*0.8, kCellHeight)];
    [m_labSubTitle setFont:[UIFont LightFontOfSize:15]];
    [m_labSubTitle setTextColor:getUIColor(0x999999)];
    m_labSubTitle.center=CGPointMake(sizeView.width*0.5, CGRectGetMaxY(m_labTitle.frame)+kCellHeight);
    [m_labSubTitle setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:m_labSubTitle];
    
}
-(void)setImage:(NSString *)img Title:(NSString *)title SubTitle:(NSString *)subTitle
{
    [m_imgView setImage:[UIImage imageNamed:img]];
    [m_labTitle setText:title];
    [m_labSubTitle setText:subTitle];
    if (title.length==0) {
        m_imgView.center=CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    }
    [m_button setHidden:YES];
}
-(void)setEmptyWith:(NSString *)img Title:(NSString *)title SubTitle:(NSString *)subTitle
{
    CGFloat imgX=(kMainScreen_Width-S(120))/2;
    CGFloat imgY=S(100);
    
    [m_imgView setFrame:CGRectMake(imgX, imgY, EMPTY_WIDTH, EMPTY_HEIGHT)];
    [m_imgView setImage:[UIImage imageNamed:img]];
    [m_labTitle setFrame:CGRectMake(0, CGRectGetMaxY(m_imgView.frame)+S(50), kMainScreen_Width, 20)];
    [m_labSubTitle setFrame:CGRectMake(0, CGRectGetMaxY(m_labTitle.frame)+10, kMainScreen_Width, 20)];
    [m_labTitle setText:title];
    [m_labSubTitle setText:subTitle];
    [m_button setHidden:YES];
}
-(void)setImage:(NSString *)img Title:(NSString *)title
{
    [m_imgView setImage:[UIImage imageNamed:img]];
    [m_labTitle setText:title];
    [m_labTitle setNumberOfLines:0];
    [m_labTitle setFrame:CGRectMake(0, CGRectGetMaxY(m_imgView.frame)+S(50), kMainScreen_Width, S(45))];
    [m_button setHidden:NO];
}
-(void)setBtnWith:(NSString *)title
{
    if (m_button==nil) {
        CGFloat orginX=(kMainScreen_Width-S(180))/2;
        m_button=[[UIButton alloc]initWithFrame:CGRectMake(orginX, CGRectGetMaxY(m_labTitle.frame)+S(35), S(180), S(40))];
        [m_button setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
        [m_button setTitle:title forState:UIControlStateNormal];
        m_button.layer.cornerRadius=5.0f;
        m_button.layer.borderWidth=0.8f;
        m_button.layer.borderColor=YELLOW_COLOR.CGColor;
        [m_button.titleLabel setFont:[UIFont LightFontOfSize:15]];
        [m_button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:m_button];
    }else{
        [m_button setHidden:NO];
    }
}
-(void)btnClicked:(id)sender
{
    if (self.clickBtnBlock) {
        self.clickBtnBlock();
    }
}


@end






