//
//  RegisterViewController.m
//  chijidun
//
//  Created by iMac on 16/8/27.
//
//

#import "RegisterViewController.h"

#define ORGIN_X S(25)
#define BTN_HEIGHT S(44)
#define FIELD_HEIGHT S(50)
@interface RegisterViewController ()
{
    CustomTextField *m_phoneField;
    CustomTextField *m_codeField;
    
    UIButton *m_btnCode;
    UIButton *m_btnNext;
    
    NSTimer *_timer;
    int _counter;
    BOOL isInitWithRestPse;
    NSString *_code;
}
@end
@implementation RegisterViewController
- (instancetype)initWithRestPsw:(BOOL)isRestPsw {
    self = [super init];
    if (self) {
        isInitWithRestPse = isRestPsw;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _counter=60;
    [self addMainView];
}

-(void)addMainView
{
    UIImageView *backView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [backView setImage:[UIImage imageNamed:@"login_background"]];
    [self.view addSubview:backView];
    
    CGFloat labX=(kMainScreen_Width-S(100))*0.5;
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(labX, S(35), S(100), S(21))];
    [labelTitle setTextAlignment:NSTextAlignmentCenter];
    [labelTitle setFont:[UIFont systemFontOfSize:S(18)]];
    [labelTitle setTextColor:WHITE_COLOR];
    [labelTitle setText:isInitWithRestPse ? @"重置密码" : @"注册"];
    [self.view addSubview:labelTitle];

    
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(S(15), S(35), S(35), S(35))];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, S(16), S(26))];
    [backBtn setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    CGFloat btnWidth=kMainScreen_Width-2*ORGIN_X;
    
    CGFloat fWidth=btnWidth+S(30);
    m_phoneField=[[CustomTextField alloc]initWithFrame:CGRectMake(ORGIN_X, S(80), fWidth, FIELD_HEIGHT) drawingLeft:@"login_tele"];
    [m_phoneField setFont:[UIFont systemFontOfSize:S(17)]];
    m_phoneField.clearX=S(140);
    [m_phoneField setPlaceholder:@"请输入手机号" Corlor:getUIColor(0xffdac5)];
    m_phoneField.delegate=self;
    m_phoneField.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:m_phoneField];
    [m_phoneField becomeFirstResponder];
    
    m_btnCode=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(m_phoneField.frame)-S(100)-S(30),m_phoneField.frame.origin.y+S(15),S(100), S(35))];
    [m_btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [m_btnCode setTitleColor:getUIColor(0xffffff) forState:UIControlStateNormal];
    m_btnCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [m_btnCode.titleLabel setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:S(13)]];
    [m_btnCode.layer addSublayer:getLine(0, 0, S(10), S(25), WHITE_COLOR)];
    [self.view addSubview:m_btnCode];
    [m_btnCode addTarget:self action:@selector(vertifyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    m_codeField=[[CustomTextField alloc]initWithFrame:CGRectMake(ORGIN_X, CGRectGetMaxY(m_phoneField.frame), fWidth, FIELD_HEIGHT) drawingLeft:@"login_vertify"];
    [m_codeField setFont:[UIFont systemFontOfSize:S(17)]];
    m_codeField.clearX=S(30);
    m_codeField.delegate=self;
    m_codeField.keyboardType=UIKeyboardTypeNumberPad;
    [m_codeField setPlaceholder:@"请输入验证码" Corlor:getUIColor(0xffdac5)];
    [self.view addSubview:m_codeField];

    
    m_btnNext=[[UIButton alloc]initWithFrame:CGRectMake(ORGIN_X, CGRectGetMaxY(m_codeField.frame)+S(30), btnWidth, BTN_HEIGHT)];
    [m_btnNext.titleLabel setFont:[UIFont systemFontOfSize:S(17)]];
    [m_btnNext setBackgroundColor:WHITE_COLOR];
    [m_btnNext setTitleColor:getUIColor(0xff5436) forState:UIControlStateNormal];
    [m_btnNext setTitle:@"下一步" forState:UIControlStateNormal];
    [m_btnNext setBackgroundImage:[UIImage imageWithColor:getUIColor(0xefdfde)] forState:UIControlStateHighlighted];
    [m_btnNext setTitleColor:getUIColor(0xae5149) forState:UIControlStateHighlighted];
    [m_btnNext addTarget:self action:@selector(btnNextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_btnNext];
}
-(void)btnNextClicked:(id)sender
{
    if (m_phoneField.text.length==0) {
        [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_phoneField.frame)-S(18), W(m_phoneField)-S(30), S(33)) Title:@"请输入手机号"];
        return;
    }
    if (![m_phoneField.text isMobile]) {
        [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_phoneField.frame)-S(18), W(m_phoneField)-S(30), S(33)) Title:@"请输入正确的手机号码"];
        return;
    }
    if (m_codeField.text.length==0) {
        [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_phoneField.frame)-S(18), W(m_phoneField)-S(30), S(33)) Title:@"请输入验证码"];
        return;
    }
    
    UserCheckRegCodeRequest *request=[UserCheckRegCodeRequest new];
    request.tele = m_phoneField.text;
    request.code=m_codeField.text;
    [apiClient disableAfterRequest];
    [apiClient doUserCheckRegCode:request success:^(NSMutableDictionary *_data, NSString *_url) {
        RegisterSecondViewController *registerVC=[[RegisterSecondViewController alloc]initWithRestPsw:isInitWithRestPse];
        registerVC.tele=m_phoneField.text;
        registerVC.code=m_codeField.text;
        [self presentVC:registerVC];
        
    }failure:^(NSDictionary *data, NSString *url){
        [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_phoneField.frame)-S(18), W(m_phoneField)-S(30), S(33)) Title:data[@"result"]];
    }];
}
//发送验证码
-(void)vertifyBtnClicked:(UIButton *)button
{
    if(button.selected) return;
    button.selected=YES;
    if ([m_phoneField.text isMobile]) {
        UserExistRequest *existRequest = [UserExistRequest new];
        existRequest.tele = m_phoneField.text;
        [apiClient disableAfterRequest];
        [apiClient doUserExist:existRequest
                       success:^(NSMutableDictionary *data, NSString *url) {
                           if (!isInitWithRestPse) {
                               [self.view showHudWith:@"该手机号码已注册"];
                               [progressbar hide:YES];
                           }else{
                               [self sendSMSCode];
                           }
                       }
                       failure:^(NSMutableDictionary *data, NSString *url) {
                           if (isInitWithRestPse) {
                               [progressbar hide:YES];
                               [self.view showHudWith:[data objectForKey:@"result"]];
                               button.selected=NO;
                           }else{
                               [self sendSMSCode];
                           }
                       }
         ];
    }
    else {
        m_btnCode.selected=NO;
        [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_phoneField.frame)-S(18), W(m_phoneField)-S(30), S(33)) Title:@"请输入正确的手机号码"];
    }
}
- (void)sendSMSCode{
    SmsSend_verify_codeRequest *request=[SmsSend_verify_codeRequest new];
    request.tele = m_phoneField.text;
    [apiClient doSmsSend_verify_code:request success:^(NSMutableDictionary *_data, NSString *_url) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    }failure:^(NSDictionary *data, NSString *url){
        m_btnCode.selected=NO;
        [self.view showHUD:data[@"result"]];
    }];
}
-(void)timerFireMethod:(NSTimer *)theTimer {
    if (_counter == 1) {
        [theTimer invalidate];
        _counter = 60;
        [m_btnCode setTitle:@"重新获取" forState: UIControlStateNormal];
        [m_btnCode setEnabled:YES];
    }else{
        _counter--;
        NSString *title = [NSString stringWithFormat:@"%d秒后重新获取",_counter];
        m_btnCode.selected=NO;
        [m_btnCode setEnabled:NO];
        [m_btnCode setTitle:title forState:UIControlStateNormal];
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self hideErrorView];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self hideErrorView];
    if (textField==m_phoneField) {
        m_btnCode.selected=NO;
        if (range.location>10) {
            return NO;
        }
        return YES;
    }
    if (textField==m_codeField) {
        if (range.location>5) {
            return NO;
        }
        return YES;
    }
    return YES;
}
@end











