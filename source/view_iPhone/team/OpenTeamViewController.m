//
//  OpenTeamViewController.m
//  chijidun
//
//  Created by iMac on 16/10/11.
//
//

#import "OpenTeamViewController.h"

@interface OpenTeamViewController ()
{
    UIImageView *m_backView;
    UITextField *m_phoneField;
    UITextField *m_nameField;
    UITextField *m_companyField;
    UIButton    *m_btnOpen;
}
@end

@implementation OpenTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申请开通企业团餐";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    
    [self addMainView];
    [self textChange];
}
-(void)addMainView
{
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [scrollView setBackgroundColor:WHITE_COLOR];
    [scrollView click:self action:@selector(clickBlank:)];
    scrollView.scrollEnabled=YES;
    [self.view addSubview:scrollView];

    
    m_backView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, S(225))];
    [m_backView setImage:[UIImage imageNamed:@"bg-applyform-header"]];
    [scrollView addSubview:m_backView];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(S(25), CGRectGetMaxY(m_backView.frame)+kDistance, 120, 20)];
    [label1 setFont:[UIFont LightFontOfSize:17]];
    [label1 setTextColor:TEXT_DEEP];
    [label1 setText:@"申请人"];
    [scrollView addSubview:label1];
    
    CGFloat width=kMainScreen_Width-S(25)-S(20);
    m_nameField=[[UITextField alloc]initWithFrame:CGRectMake(S(25), CGRectGetMaxY(label1.frame)+kDistanceMin, width, kCellHeight)];
    [m_nameField setBackgroundColor:WHITE_COLOR];
    [m_nameField setLeftDistance:kCellHeight];
    m_nameField.layer.cornerRadius=5.0f;
    m_nameField.layer.borderWidth=1.0f;
    m_nameField.layer.borderColor=BORDER_COLOR.CGColor;
    [m_nameField setPlaceholder:@"申请人姓名"];
    [m_nameField setFont:[UIFont LightFontOfSize:15]];
    m_nameField.delegate=self;
    [scrollView addSubview:m_nameField];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(S(25), CGRectGetMaxY(m_nameField.frame)+kDistance, 120, 20)];
    [label2 setFont:[UIFont LightFontOfSize:17]];
    [label2 setTextColor:TEXT_DEEP];
    [label2 setText:@"联系方式"];
    [scrollView addSubview:label2];
    m_phoneField=[[UITextField alloc]initWithFrame:CGRectMake(S(25), CGRectGetMaxY(label2.frame)+kDistanceMin, width, kCellHeight)];
    [m_phoneField setBackgroundColor:WHITE_COLOR];
    [m_phoneField setLeftDistance:40];
    m_phoneField.layer.cornerRadius=5.0f;
    m_phoneField.layer.borderWidth=1.0f;
    m_phoneField.layer.borderColor=BORDER_COLOR.CGColor;
    [m_phoneField setPlaceholder:@"手机号码"];
    m_phoneField.keyboardType=UIKeyboardTypeNumberPad;
    [m_phoneField setFont:[UIFont LightFontOfSize:15]];
    m_phoneField.delegate=self;
    [scrollView addSubview:m_phoneField];
    
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(S(25), CGRectGetMaxY(m_phoneField.frame)+kDistance, 120, 20)];
    [label3 setFont:[UIFont LightFontOfSize:17]];
    [label3 setTextColor:TEXT_DEEP];
    [label3 setText:@"公司名称"];
    [scrollView addSubview:label3];
    m_companyField=[[UITextField alloc]initWithFrame:CGRectMake(S(25), CGRectGetMaxY(label3.frame)+kDistanceMin, width, kCellHeight)];
    [m_companyField setBackgroundColor:WHITE_COLOR];
    [m_companyField setLeftDistance:kCellHeight];
    m_companyField.layer.cornerRadius=5.0f;
    m_companyField.layer.borderWidth=1.0f;
    m_companyField.layer.borderColor=BORDER_COLOR.CGColor;
    [m_companyField setPlaceholder:@"公司全称"];
    [m_companyField setFont:[UIFont LightFontOfSize:15]];
    m_companyField.delegate=self;
    [scrollView addSubview:m_companyField];
    
    m_btnOpen=[[UIButton alloc]initWithFrame:CGRectMake(S(25), CGRectGetMaxY(m_companyField.frame)+2*kDistance, width, kCellHeight)];
    [m_btnOpen setBackgroundColor:MAIN_COLOR];
    m_btnOpen.layer.cornerRadius=5.0f;
    [m_btnOpen setTitle:@"申请开通" forState:UIControlStateNormal];
    [m_btnOpen.titleLabel setFont:[UIFont LightFontOfSize:17]];
    [scrollView addSubview:m_btnOpen];
    [m_btnOpen addTarget:self action:@selector(btnOpenClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView setContentSize:CGSizeMake(W(scrollView), CGRectGetMaxY(m_btnOpen.frame)+kCellHeight+NAV_HEIGHT)];
    scrollView.showsVerticalScrollIndicator = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:m_nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:m_phoneField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:m_companyField];
    [self addKeyboardNote:CGRectGetMaxY(m_companyField.frame)];
}
-(void)textChange
{
    m_btnOpen.enabled= (m_nameField.text.length>0 && m_phoneField.text.length==11&&m_companyField.text.length>0);
    if (m_btnOpen.enabled) {
        [m_btnOpen setBackgroundColor:MAIN_COLOR];
    }else{
        [m_btnOpen setBackgroundColor:BORDER_COLOR];
    }
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==m_phoneField) {
        if (range.location>10) {
            return NO;
        }
        return YES;
    }
    return YES;
}

-(void)btnOpenClicked:(UIButton *)button
{
    //[self showNavigationView:[JoinTeamViewController new]];    
    [[App shared] readDeviceToken];
    SaveCompanyMealApplyRequest *request = [SaveCompanyMealApplyRequest new];
    request.mobile=m_phoneField.text;
    request.name=m_nameField.text;
    request.companyName=m_companyField.text;
    request.deviceId=[App shared].deviceToken;
    [cgClient doSaveCompanyMealApply:request success:^(CGResponse *data, NSString *url) {
        [self goBack];
    }];
}
-(void)clickBlank:(id)sender
{
    [self textFieldDone];
}
@end
