//
//  JoinTeamViewController.m
//  chijidun
//
//  Created by iMac on 16/10/11.
//
//

#import "JoinTeamViewController.h"

@interface JoinTeamViewController ()
{
    UIImageView *m_backView;
    UITextField *m_codeField;
    UITextField *m_companyField;
    UIButton    *m_btnJoin;
    
    NSString *_companyname;
}
@end

@implementation JoinTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"加入已开通企业";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    
    [self addMainView];
    [self textChange];
}
-(void)addMainView
{
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [scrollView click:self action:@selector(clickBlank:)];
    [scrollView setBackgroundColor:WHITE_COLOR];
    scrollView.scrollEnabled=YES;
    [self.view addSubview:scrollView];
    
    m_backView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, S(225))];
    [m_backView setImage:[UIImage imageNamed:@"bg-applycodeform-header"]];
    [scrollView addSubview:m_backView];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(S(25), CGRectGetMaxY(m_backView.frame)+kDistance, 120, 20)];
    [label1 setFont:[UIFont LightFontOfSize:17]];
    [label1 setTextColor:TEXT_DEEP];
    [label1 setText:@"邀请码"];
    [scrollView addSubview:label1];
    
    CGFloat width=kMainScreen_Width-S(25)-S(20);
    m_codeField=[[UITextField alloc]initWithFrame:CGRectMake(S(25), CGRectGetMaxY(label1.frame)+kDistanceMin, width, kCellHeight)];
    [m_codeField setBackgroundColor:WHITE_COLOR];
    [m_codeField setLeftDistance:40];
    m_codeField.layer.cornerRadius=5.0f;
    m_codeField.layer.borderWidth=1.0f;
    m_codeField.delegate=self;
    [m_codeField setFont:[UIFont LightFontOfSize:15]];
    m_codeField.layer.borderColor=BORDER_COLOR.CGColor;
    [m_codeField setPlaceholder:@"输入6位邀请码"];
    [scrollView addSubview:m_codeField];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(S(25), CGRectGetMaxY(m_codeField.frame)+kDistance, 120, 20)];
    [label2 setFont:[UIFont LightFontOfSize:17]];
    [label2 setTextColor:TEXT_DEEP];
    [label2 setText:@"公司名称"];
    [scrollView addSubview:label2];
    m_companyField=[[UITextField alloc]initWithFrame:CGRectMake(S(25), CGRectGetMaxY(label2.frame)+kDistanceMin, width, kCellHeight)];
    [m_companyField setBackgroundColor:WHITE_COLOR];
    [m_companyField setPlaceholder:@"公司全称"];
    [m_companyField setLeftDistance:40];
    m_companyField.layer.cornerRadius=5.0f;
    m_companyField.layer.borderWidth=1.0f;
    m_companyField.enabled=NO;
    m_companyField.delegate=self;
    [m_companyField setFont:[UIFont LightFontOfSize:15]];
    m_companyField.layer.borderColor=BORDER_COLOR.CGColor;
    [scrollView addSubview:m_companyField];
    
    m_btnJoin=[[UIButton alloc]initWithFrame:CGRectMake(S(25), CGRectGetMaxY(m_companyField.frame)+2*kDistance, width, kCellHeight)];
    [m_btnJoin setBackgroundColor:MAIN_COLOR];
    m_btnJoin.layer.cornerRadius=5.0f;
    [m_btnJoin setTitle:@"确认加入" forState:UIControlStateNormal];
    [m_btnJoin.titleLabel setFont:[UIFont LightFontOfSize:17]];
    [scrollView addSubview:m_btnJoin];
    [m_btnJoin addTarget:self action:@selector(btnJoinClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:m_codeField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:m_companyField];
    [self addKeyboardNote:CGRectGetMaxY(m_companyField.frame)];
}
-(void)textChange
{
    if (m_codeField.text.length==6) {
        [self GetCompanyName];
    }
    m_btnJoin.enabled= (m_codeField.text.length==6 && m_companyField.text.length>0);
    if (m_btnJoin.enabled) {
        [m_btnJoin setBackgroundColor:MAIN_COLOR];
    }else{
        [m_btnJoin setBackgroundColor:BORDER_COLOR];
    }
}
-(void)GetCompanyName
{
    GetCompanyNameRequest *request = [GetCompanyNameRequest new];
    request.code=m_codeField.text;
    [cgClient doGetCompanyName:request success:^(CGResponse *data, NSString *url) {
        _companyname=data.data[@"name"];
        [m_companyField setText:_companyname];
        m_btnJoin.enabled=YES;
        [m_btnJoin setBackgroundColor:MAIN_COLOR];
    }failure:^(CGResponse *data, NSString *url){
        _companyname=@"";
        [m_companyField setText:@""];
        m_btnJoin.enabled=NO;
        [m_btnJoin setBackgroundColor:BORDER_COLOR];
        [self.view showHUD:data.result];
    }];
}
-(void)btnJoinClicked:(UIButton *)button
{
    if (m_codeField.text.length !=6) {
        [self.view showHUD:@"邀请码错误，请重新输入"];
        return;
    }
    if (m_companyField.text.length ==0) {
        [self.view showHUD:@"请输入公司名称"];
        return;
    }
    
    SaveCompanyMealByInviteRequest *request = [SaveCompanyMealByInviteRequest new];
    request.code=m_codeField.text;
    request.name=m_companyField.text;
    [cgClient doSaveCompanyMealByInvite:request success:^(CGResponse *data, NSString *url) {
        NSString *string=[NSString stringWithFormat:@"欢迎加入%@！",_companyname];
        [self.view showHUDDesc:string];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self goBack];
        });
    }];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor=MAIN_COLOR.CGColor;
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.layer.borderColor=BORDER_COLOR.CGColor;
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==m_codeField) {
        if (range.location>5) {
            return NO;
        }
        return YES;
    }
    return YES;
}
-(void)clickBlank:(id)sender
{
    [self textFieldDone];
}
@end






