//
//  TeamUnjoinView.m
//  chijidun
//
//  Created by iMac on 16/9/21.
//
//

#import "TeamUnjoinView.h"

#define TEAM_DESC @"精选优质私厨      家的味道\n严选品牌餐饮      健康放心"
#define TEAM_DESC2 @"不再担心员工餐饮福利问题\n轻松预定，乐享一周"
#define TEAM_DESC3 @"赶紧来开通吧"

@interface TeamUnjoinView ()
{
    UILabel *m_labHeader;
    UIButton *m_btnOpen;
    UIButton *m_btnLogin;
}
@end
@implementation TeamUnjoinView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addMainView];
    }
    return self;
}
-(void)addMainView
{
    [self setBackgroundColor:getUIColor(0xfff7e7)];
    
    CGFloat orginX=(kMainScreen_Width-S(242))/2;
    UIImageView *headerView=[[UIImageView alloc]initWithFrame:CGRectMake(orginX, kDistance, S(242), S(242))];
    [headerView setImage:[UIImage imageNamed:@"bg-applyindex-header"]];
    [self addSubview:headerView];
    
    CGFloat height=kMainScreen_Height-NAV_HEIGHT-kNAV_HEIGHT;
    UIImageView *footer=[[UIImageView alloc]initWithFrame:CGRectMake(0, height-S(165), kMainScreen_Width, S(80))];
    [footer setImage:[UIImage imageNamed:@"bg-applyindex-content"]];
    [self addSubview:footer];
    
    CGFloat textX=S(60);
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(textX, CGRectGetMaxY(headerView.frame)+S(25), kMainScreen_Width-2*textX, S(50))];
    [label1 setNumberOfLines:0];
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [label1 setFont:[UIFont LightFontOfSize:17]];
    [label1 setText:TEAM_DESC];
    [label1 setTextColor:getUIColor(0x7d5623)];
    [self addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(textX, CGRectGetMaxY(label1.frame)+S(20), kMainScreen_Width-2*textX, S(50))];
    [label2 setNumberOfLines:0];
    [label2 setTextAlignment:NSTextAlignmentCenter];
    [label2 setFont:[UIFont LightFontOfSize:17]];
    [label2 setText:TEAM_DESC2];
    [label2 setTextColor:getUIColor(0x7d5623)];
    [self addSubview:label2];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(textX, CGRectGetMaxY(label2.frame)+S(20), kMainScreen_Width-2*textX, S(20))];
    [label3 setTextAlignment:NSTextAlignmentCenter];
    [label3 setFont:[UIFont BoldFontOfSize:17]];
    [label3 setText:TEAM_DESC3];
    [label3 setTextColor:getUIColor(0x7d5623)];
    [self addSubview:label3];
    
    
    m_btnOpen=[[UIButton alloc]initWithFrame:CGRectMake(kDistanceMin, height-S(85), S(170), S(40))];
    [m_btnOpen.titleLabel setFont:[UIFont LightFontOfSize:17]];
    m_btnOpen.layer.cornerRadius=S(20.0);
    [m_btnOpen setBackgroundColor:MAIN_COLOR];
    [m_btnOpen setTitle:@"申请开通" forState:UIControlStateNormal];
    [self addSubview:m_btnOpen];
    [m_btnOpen addTarget:self action:@selector(btnOpenClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    m_btnLogin=[[UIButton alloc]initWithFrame:CGRectMake(kMainScreen_Width-kDistanceMin-S(170), height-S(85), S(170), S(40))];
    [m_btnLogin.titleLabel setFont:[UIFont LightFontOfSize:17]];
    m_btnLogin.layer.cornerRadius=S(20.0);
    m_btnLogin.layer.borderWidth=1.0f;
    [m_btnLogin setBackgroundColor:WHITE_COLOR];
    m_btnLogin.layer.borderColor=MAIN_COLOR.CGColor;
    [m_btnLogin setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [m_btnLogin setTitle:@"点餐登录" forState:UIControlStateNormal];
    [m_btnLogin addTarget:self action:@selector(btnLoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:m_btnLogin];
    
    m_labHeader=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kCellHeight)];
    [m_labHeader setBackgroundColor:RED_COLOR];
    [m_labHeader setTextColor:WHITE_COLOR];
    [m_labHeader setFont:[UIFont LightFontOfSize:17]];
    [self addSubview:m_labHeader];
    [m_labHeader setHidden:YES];
    
//    CGFloat forX=(kMainScreen_Width-S(110))/2;
//    UILabel *labForward = [[UILabel alloc] initWithFrame:CGRectMake(forX, height-S(35), S(110), S(18))];
//    [labForward click:self action:@selector(btnForwardClicked:)];
//    [labForward setTextAlignment:NSTextAlignmentCenter];
//    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"转发给我们的行政"]];
//    NSRange contentRange = {0,[content length]};
//    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
//    [content addAttribute:NSForegroundColorAttributeName value:getUIColor(0x0099ff) range:contentRange];
//    [content addAttribute:NSFontAttributeName value:[UIFont LightFontOfSize:13] range:contentRange];
//    labForward.attributedText = content;
//    [self addSubview:labForward];

}
-(void)reloadViews
{
    [[App shared] restore];
    USER *user = [[App shared] currentUser];
    CGFloat height=kMainScreen_Height-NAV_HEIGHT-kNAV_HEIGHT;
    CGFloat X=kMainScreen_Width/2-S(250)/2;
    if (_hasCompany.has.intValue==1) {
        if (_hasCompany.status.intValue==1) {
            [m_labHeader setText:@" 您的账户已被冻结..."];
            [m_btnOpen setBackgroundColor:BORDER_COLOR];
            [m_btnOpen setEnabled:NO];
            [m_labHeader setHidden:NO];
            [m_btnLogin setHidden:YES];
            [m_btnOpen setFrame:CGRectMake(X, height-S(85), S(250), S(40))];
        }else if (_hasCompany.status.intValue==2){
            [m_labHeader setText:@" 您已提交申请，正在审核中..."];
            [m_btnOpen setBackgroundColor:BORDER_COLOR];
            [m_btnOpen setEnabled:NO];
            [m_labHeader setHidden:NO];
            [m_btnLogin setHidden:YES];
            [m_btnOpen setFrame:CGRectMake(X, height-S(85), S(250), S(40))];
        }else if (_hasCompany.status.intValue==3){
            [m_labHeader setText:@" 您提交的申请未通过审核..."];
            [m_btnOpen setBackgroundColor:BORDER_COLOR];
            [m_btnOpen setEnabled:NO];
            [m_labHeader setHidden:NO];
            [m_btnLogin setHidden:YES];
            [m_btnOpen setFrame:CGRectMake(X, height-S(85), S(250), S(40))];
        }
    }else{
        if (_hasCompany.apply.intValue==1) {
            [m_labHeader setText:@" 您已提交申请，正在审核中..."];
            [m_labHeader setHidden:NO];
            [m_btnOpen setBackgroundColor:BORDER_COLOR];
            [m_btnOpen setEnabled:NO];
        }else{
            [m_labHeader setHidden:YES];
            [m_btnOpen setBackgroundColor:MAIN_COLOR];
            [m_btnOpen setEnabled:YES];
        }
        [m_btnOpen setFrame:CGRectMake(kDistanceMin, height-S(85), S(170), S(40))];
        [m_btnLogin setHidden:NO];
        if (user.token.length==0) {
            [m_btnLogin setTitle:@"点餐登录" forState:UIControlStateNormal];
        }else{
            [m_btnLogin setTitle:@"加入自己团队" forState:UIControlStateNormal];
        }
    }
}
-(void)btnOpenClicked:(id)sender
{
    TeamOrderListVC *teamVC = (TeamOrderListVC *) self.nextResponder;
    OpenTeamViewController *openVC=[[OpenTeamViewController alloc]init];  
    [teamVC showNavigationView:openVC];
}
-(void)btnForwardClicked:(id)sender
{
    NSLog(@"forward");
}
-(void)btnLoginClicked:(id)sender
{
    [[App shared] restore];
    USER *user = [[App shared] currentUser];
    TeamOrderListVC *teamVC = (TeamOrderListVC *) self.nextResponder;
    if (user.token.length==0) {
        [teamVC presentVC:[LoginViewController new]];
    }else{
        [teamVC showNavigationView:[JoinTeamViewController new]];
    }
}


@end






