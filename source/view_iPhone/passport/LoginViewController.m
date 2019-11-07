//
//  LoginViewController.m
//  chijidun
//
//  Created by iMac on 16/8/26.
//
//

#import "LoginViewController.h"

#define LOGO_WIDTH S(235)
#define LOGO_HEIGHT S(184)
#define ORGIN_X S(35)
#define BTN_HEIGHT S(44)
#define FIELD_HEIGHT S(50)
@interface LoginViewController ()
{
    CustomTextField *m_phoneField;
    CustomTextField *m_passwordField;
    
    UIButton *m_btnLogin;
    UIButton *m_btnRegister;
    UIButton *m_btnForget;
    CGFloat _maxY;
    UIButton *m_backBtn;
}
@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addMainView];
}

-(void)addMainView
{
    UIImageView *backView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [backView setImage:[UIImage imageNamed:@"login_background"]];
    [self.view addSubview:backView];
    
    CGFloat logoX=(kMainScreen_Width-LOGO_WIDTH)*0.5;
    UIImageView *logoView=[[UIImageView alloc]initWithFrame:CGRectMake(logoX, S(100), LOGO_WIDTH, LOGO_HEIGHT)];
    [logoView setImage:[UIImage imageNamed:@"login_logo"]];
    [backView addSubview:logoView];
    
    m_backBtn=[[UIButton alloc]initWithFrame:CGRectMake(kMainScreen_Width-S(50), S(60), S(25), S(25))];
    [m_backBtn setImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
    [m_backBtn addTarget:self action:@selector(goHomeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_backBtn];
    
    CGFloat btnWidth=kMainScreen_Width-2*ORGIN_X;
    CGFloat fWidth=btnWidth+S(30);
    m_phoneField=[[CustomTextField alloc]initWithFrame:CGRectMake(ORGIN_X, S(320), fWidth, FIELD_HEIGHT) drawingLeft:@"login_tele"];
    [m_phoneField setFont:[UIFont systemFontOfSize:S(17)]];
    [m_phoneField setPlaceholder:@"请输入手机号" Corlor:getUIColor(0xffdac5)];
    m_phoneField.delegate=self;
    m_phoneField.keyboardType=UIKeyboardTypeNumberPad;
    [self.view addSubview:m_phoneField];
    
    m_passwordField=[[CustomTextField alloc]initWithFrame:CGRectMake(ORGIN_X, CGRectGetMaxY(m_phoneField.frame), fWidth, FIELD_HEIGHT) drawingLeft:@"login_password"];
    [m_passwordField setFont:[UIFont systemFontOfSize:S(17)]];
    [m_passwordField setPlaceholder:@"请输入密码" Corlor:getUIColor(0xffdac5)];
    m_passwordField.delegate=self;
    m_passwordField.secureTextEntry=YES;
    m_passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:m_passwordField];
    
    m_btnLogin=[[UIButton alloc]initWithFrame:CGRectMake(ORGIN_X, CGRectGetMaxY(m_passwordField.frame)+S(30), btnWidth, BTN_HEIGHT)];
    [m_btnLogin.titleLabel setFont:[UIFont systemFontOfSize:S(17)]];
    [m_btnLogin setBackgroundColor:WHITE_COLOR];
    [m_btnLogin setTitleColor:getUIColor(0xff5436) forState:UIControlStateNormal];
    [m_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [m_btnLogin setBackgroundImage:[UIImage imageWithColor:getUIColor(0xefdfde)] forState:UIControlStateHighlighted];
    [m_btnLogin setTitleColor:getUIColor(0xae5149) forState:UIControlStateHighlighted];
    [m_btnLogin addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_btnLogin];
    [self addKeyboardNote:CGRectGetMaxY(m_btnLogin.frame)];
    _maxY=CGRectGetMaxY(m_btnLogin.frame);
    
    m_btnForget=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(m_btnLogin.frame)-S(70), CGRectGetMaxY(m_btnLogin.frame), S(70), S(30))];
    [m_btnForget setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [m_btnForget.titleLabel setFont:[UIFont systemFontOfSize:S(13)]];
    [m_btnForget.titleLabel setTextAlignment:NSTextAlignmentRight];
    [m_btnForget setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.view addSubview:m_btnForget];
    [m_btnForget addTarget:self action:@selector(forgetPasswordBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    m_btnRegister=[[UIButton alloc]initWithFrame:CGRectMake(ORGIN_X, CGRectGetMaxY(m_btnLogin.frame)+S(70), btnWidth, BTN_HEIGHT)];
    [m_btnRegister.titleLabel setFont:[UIFont systemFontOfSize:S(17)]];
    [m_btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    
    [m_btnRegister addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchDown];
    
    [m_btnRegister setBackgroundImage:[UIImage imageNamed:@"register_selected"] forState:UIControlStateHighlighted];
    [m_btnRegister setTitleColor:getUIColor(0xae5149) forState:UIControlStateHighlighted];
    [self.view addSubview:m_btnRegister];
    [m_btnRegister addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    m_btnRegister.layer.borderWidth=1.0f;
    m_btnRegister.layer.borderColor=WHITE_COLOR.CGColor;

}
- (void)buttonTouch:(UIButton *)button
{
    button.layer.borderWidth=0.0f;
}
-(void)loginBtnClicked:(id)sender
{
    if (m_phoneField.text.length==0) {
        [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_phoneField.frame)-S(33), W(m_phoneField)-S(30), S(33)) Title:@"请输入手机号码"];
        return;
    }
    if (m_passwordField.text.length==0) {
        [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_phoneField.frame)-S(33), W(m_phoneField)-S(30), S(33)) Title:@"请输入密码"];
        return;
    }
    if (m_passwordField.text.length<6||m_passwordField.text.length>32) {
        [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_phoneField.frame)-S(33), W(m_phoneField)-S(30), S(33)) Title:@"请输入6-32位字符密码"];
        return;
    }
    if ([m_phoneField.text isMobile]) {
        UserLoginNewRequest *request = [UserLoginNewRequest new];
        request.tele = m_phoneField.text;
        request.password = [CocoaSecurity md5:m_passwordField.text].hexLower;
        ////[cgClient disableAfterRequest];
        [cgClient doUserLoginNew:request success:^(CGResponse *data, NSString *url) {
            UserLoginNewResponse *response=[[UserLoginNewResponse alloc]initWithCGResponse:data];
            [App shared].user = response.data;
            [[App shared] save];
            [[App shared] restore];
            [self.view showHudWith:@"登录成功！"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self goBack];
                NSNotification *notification =[NSNotification notificationWithName:@"loginSuccess" object:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            });
        }failure:^(CGResponse *data, NSString *url){
            [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_phoneField.frame)-S(33), W(m_phoneField)-S(30), S(33)) Title:data.result];
        }];
    }else {
        [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_phoneField.frame)-S(33), W(m_phoneField)-S(30), S(33)) Title:@"请输入正确的手机号码"];
    }
}
-(void)registerBtnClicked:(UIButton *)sender
{
    [self presentVC:[RegisterViewController new]];
    sender.layer.borderWidth=1.0f;
}
-(void)forgetPasswordBtnClicked:(id)sender
{
    RegisterViewController *forgetVC=[[RegisterViewController alloc]initWithRestPsw:YES];
    [self presentVC:forgetVC];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self hideErrorView];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self hideErrorView];
    if (textField==m_phoneField) {
        if (range.location>10) {
            return NO;
        }
        return YES;
    }
    return YES;
}
-(void)goHomeVC
{
    if (_isRegister) {
        [self.presentingViewController.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self goBack];
    }
}
- (void)keyboardWillShow:(NSNotification *)note
{
    CGFloat keyboardH = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat keyboardY = self.view.frame.size.height - keyboardH;
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (duration <= 0.0) {
        duration = 0.25;
    }
    [UIView animateWithDuration:duration animations:^{
        if (_maxY > keyboardY) {
            self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - _maxY - 5);
            m_backBtn.transform = CGAffineTransformMakeTranslation(0, _maxY-keyboardY);
        } else {
            self.view.transform = CGAffineTransformIdentity;
        }
    }];
}
#pragma mark 隐藏键盘就会调用
- (void)keyboardWillHide:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
        m_backBtn.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}
@end













