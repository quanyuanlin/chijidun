//
//  CharacterPayView.m
//  chijidun
//
//  Created by iMac on 16/10/12.
//
//

#import "CharacterPayView.h"

#define BACK_WIDTH 250
#define BACK_HEIGHT 150
@interface CharacterPayView ()
{
    UIView *m_whiteView;
    UIButton *m_deleteBtn;
}
@end
@implementation CharacterPayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addMainView];
    }
    return self;
}
-(void)addMainView
{
    UIView *backView=[[UIView alloc]initWithFrame:self.bounds];
    [backView setBackgroundColor:[UIColor blackColor]];
    [backView setAlpha:0.6];
    [self addSubview:backView];
    [backView click:self action:@selector(clickBlank:)];
    
    CGFloat orginX=(kMainScreen_Width-BACK_WIDTH)/2;
    m_whiteView=[[UIView alloc]initWithFrame:CGRectMake(orginX, 190, BACK_WIDTH, BACK_HEIGHT)];
    m_whiteView.layer.cornerRadius=5.0f;
    [m_whiteView setBackgroundColor:WHITE_COLOR];
    [self addSubview:m_whiteView];
    [m_whiteView.layer addSublayer:getLine(0, BACK_WIDTH, kCart_HEIGHT, kCart_HEIGHT, BORDER_COLOR)];
    
    
    m_deleteBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 16, 16)];
    [m_deleteBtn setImage:[UIImage imageNamed:@"delete_sms"] forState:UIControlStateNormal];
    [m_deleteBtn addTarget:self action:@selector(clickBlank:) forControlEvents:UIControlEventTouchUpInside];
    [m_whiteView addSubview:m_deleteBtn];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(2*kDistance, 0, BACK_WIDTH-4*kDistance, kCart_HEIGHT)];
    [label setFont:[UIFont LightFontOfSize:17]];
    [label setTextColor:TEXT_DEEP];
    [label setText:@"请输入短信验证码"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [m_whiteView addSubview:label];
    
    CGFloat left=25;
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(0, kCart_HEIGHT+kDistance, BACK_WIDTH, 20)];
    [lab2 setTextColor:RED_COLOR];
    [lab2 setTextAlignment:NSTextAlignmentCenter];
    [lab2 setFont:[UIFont LightFontOfSize:13]];
    [lab2 setText:@"51人品付短信验证码10分钟内有效"];
    [m_whiteView addSubview:lab2];

    EnterCodeView *codeView = [[EnterCodeView alloc] initWithFrame:CGRectMake(left, CGRectGetMaxY(lab2.frame)+kDistance, BACK_WIDTH-2*left, 35) num:6 lineColor:BORDER_COLOR textFont:17];
    codeView.hasSpaceLine = YES;
    codeView.codeType = CodeViewTypeCustom;
    codeView.emptyEditEnd=YES;
    [codeView beginEdit];
    codeView.EndEditBlcok = ^(NSString *str) {
        [self removeFromSuperview];
        [self endInputCodeWith:str];
    };
    [m_whiteView addSubview:codeView];
    
}
-(void)clickBlank:(id)sender
{
    [self removeFromSuperview];
}
-(void)endInputCodeWith:(NSString *)code
{
    if (self.codeBlock) {
        self.codeBlock(code);
    }
}

@end
