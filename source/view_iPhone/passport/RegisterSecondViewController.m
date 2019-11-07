//
//  RegisterSecondViewController.m
//  chijidun
//
//  Created by iMac on 16/8/27.
//
//

#import "RegisterSecondViewController.h"

#define ORGIN_X S(25)
#define BTN_HEIGHT S(44)
#define FIELD_HEIGHT S(50)
@interface RegisterSecondViewController ()
{
    CustomTextField *m_nameField;
    CustomTextField *m_passwordField;
    
    UIButton *m_btnConfirm;
    BOOL isInitWithRestPse;
}
@end
@implementation RegisterSecondViewController
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
    
    if (isInitWithRestPse) {
        m_nameField=[[CustomTextField alloc]initWithFrame:CGRectMake(ORGIN_X, S(80), fWidth, FIELD_HEIGHT) drawingLeft:@"login_password"];
        [m_nameField setPlaceholder:@"请输入6-32位字符密码" Corlor:getUIColor(0xffdac5)];
        m_passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    }else{
        m_nameField=[[CustomTextField alloc]initWithFrame:CGRectMake(ORGIN_X, S(80), fWidth, FIELD_HEIGHT) drawingLeft:@"login_name"];
        [m_nameField setPlaceholder:@"取个好听的名字吧" Corlor:getUIColor(0xffdac5)];
    }
    [m_nameField setFont:[UIFont systemFontOfSize:S(17)]];
    m_nameField.clearX=S(30);
    m_nameField.delegate=self;
    [self.view addSubview:m_nameField];
    m_nameField.secureTextEntry=isInitWithRestPse;
    
    m_passwordField=[[CustomTextField alloc]initWithFrame:CGRectMake(ORGIN_X, CGRectGetMaxY(m_nameField.frame), fWidth, FIELD_HEIGHT) drawingLeft:@"login_password"];
    [m_passwordField setFont:[UIFont systemFontOfSize:S(17)]];
    m_passwordField.clearX=S(30);
    if (isInitWithRestPse) {
        [m_passwordField setPlaceholder:@"请输入密码" Corlor:getUIColor(0xffdac5)];
    }else{
        [m_passwordField setPlaceholder:@"请输入密码" Corlor:getUIColor(0xffdac5)];
    }
    m_passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    m_passwordField.delegate=self;
    [self.view addSubview:m_passwordField];
    m_passwordField.secureTextEntry=isInitWithRestPse;
    
    m_btnConfirm=[[UIButton alloc]initWithFrame:CGRectMake(ORGIN_X, CGRectGetMaxY(m_passwordField.frame)+S(30), btnWidth, BTN_HEIGHT)];
    [m_btnConfirm.titleLabel setFont:[UIFont systemFontOfSize:S(17)]];
    [m_btnConfirm setBackgroundColor:WHITE_COLOR];
    [m_btnConfirm setTitleColor:getUIColor(0xff5436) forState:UIControlStateNormal];
    [m_btnConfirm setTitle:isInitWithRestPse ? @"确认提交" : @"确认注册" forState:UIControlStateNormal];
    [m_btnConfirm addTarget:self action:@selector(btnConfirmClicked:) forControlEvents:UIControlEventTouchUpInside];
    [m_btnConfirm setBackgroundImage:[UIImage imageWithColor:getUIColor(0xefdfde)] forState:UIControlStateHighlighted];
    [m_btnConfirm setTitleColor:getUIColor(0xae5149) forState:UIControlStateHighlighted];
    [self.view addSubview:m_btnConfirm];

}
-(void)btnConfirmClicked:(id)sender
{
    if (m_nameField.text.length==0) {
        NSString *error=isInitWithRestPse ? @"请输入6-32位字符密码" : @"请输入昵称";
        [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_nameField.frame)-S(18), W(m_nameField)-S(30), S(33)) Title:error];
        return;
    }
    if (m_passwordField.text.length==0) {
        [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_nameField.frame)-S(18), W(m_nameField)-S(30), S(33)) Title:@"请输入6-32位字符密码"];
        return;
    }
    if (isInitWithRestPse) {
        if (m_nameField.text.length<6||m_nameField.text.length>32) {
            [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_nameField.frame)-S(18), W(m_nameField)-S(30), S(33)) Title:@"请输入6-32位字符密码"];
            return;
        }
    }
    if (m_passwordField.text.length<6||m_passwordField.text.length>32) {
        [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_nameField.frame)-S(18), W(m_nameField)-S(30), S(33)) Title:@"请输入6-32位字符密码"];
        return;
    }
    if (isInitWithRestPse) {
        if (![m_nameField.text isEqualToString:m_passwordField.text]) {
            [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_nameField.frame)-S(18), W(m_nameField)-S(30), S(33)) Title:@"两次密码必须一样"];
            return;
        }
    }
    if (isInitWithRestPse) {
        UserResetPasswordRequest *request = [UserResetPasswordRequest new];
        request.tele = self.tele;
        request.code = self.code;
        request.newpassword = [CocoaSecurity md5:m_nameField.text].hexLower;
        request.oldpassword= [CocoaSecurity md5:m_passwordField.text].hexLower;
        //[cgClient disableAfterRequest];
        [cgClient doUserResetPassword:request success:^(CGResponse *data, NSString *url) {
            UserResetPasswordResponse *response=[[UserResetPasswordResponse alloc]initWithCGResponse:data];
             NSLog(@"%@",response.data);
            [self.view showHudWith:data.result];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self loginIn];
            });
        }failure:^(CGResponse *data, NSString *url) {
            [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_nameField.frame)-S(18), W(m_nameField)-S(30), S(33)) Title:data.result];
        }];
    }else{
        UserRegisterRequest *request = [UserRegisterRequest new];
        request.tele = self.tele;
        request.code = self.code;
        request.password = [CocoaSecurity md5:m_passwordField.text].hexLower;
        request.username=m_nameField.text;
        //[cgClient disableAfterRequest];
        [cgClient doUserRegister:request success:^(CGResponse *data, NSString *url) {
            UserRegisterResponse *response=[[UserRegisterResponse alloc]initWithCGResponse:data];
            NSLog(@"%@",response.data);
            [self.view showHudWith:data.result];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self loginIn];
            });
        }failure:^(CGResponse *data, NSString *url) {
            [self showErrorWith:CGRectMake(ORGIN_X, CGRectGetMinY(m_nameField.frame)-S(18), W(m_nameField)-S(30), S(33)) Title:data.result];
        }];
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
    return YES;
}
-(void)goLoginVC
{
    LoginViewController *loginVC=[[LoginViewController alloc]init];
    loginVC.isRegister=YES;
    [self presentVC:loginVC];
}
-(void)loginIn
{
    UserLoginNewRequest *request = [UserLoginNewRequest new];
    request.tele = _tele;
    request.password = [CocoaSecurity md5:m_passwordField.text].hexLower;
    [cgClient disableAfterRequest];
    [cgClient doUserLoginNew:request success:^(CGResponse *data, NSString *url) {
        UserLoginNewResponse *response=[[UserLoginNewResponse alloc]initWithCGResponse:data];
        [App shared].user = response.data;
        [[App shared] save];
        [[App shared] restore];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSNotification *notification =[NSNotification notificationWithName:@"loginSuccess" object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [self.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}

@end



