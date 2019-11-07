#import "UserSettingViewController.h"
#import "WebHtmlViewController.h"

@interface UserSettingViewController () {
    UITableView *m_tableView;
    UIButton *m_btnExit;
}
@end

@implementation UserSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.view.layer addSublayer:getLine(0, kMainScreen_Width, 64, 64, BORDER_COLOR)];
    self.user = [[App shared] currentUser];

    self.title = @"其它设置";
    self.navigationItem.leftBarButtonItem = [self tbarBackButton];
    self.view.backgroundColor = WHITE_COLOR;

    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
    [m_tableView setBackgroundColor:getUIColor(0xf8f8f8)];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    [self.view addSubview:m_tableView];

    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, NAV_HEIGHT)];
    m_btnExit = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreen_Width * 0.05, kCellHeight * 0.5, kMainScreen_Width * 0.9, kNAV_HEIGHT)];
    [m_btnExit setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [m_btnExit setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [m_btnExit.titleLabel setFont:FONT_DEFAULT15];
    m_btnExit.backgroundColor = MAIN_COLOR;
    m_btnExit.layer.cornerRadius = 5;
    [m_btnExit addTarget:self action:@selector(btnLoginOutTapped:) forControlEvents:UIControlEventTouchUpInside];
    [m_btnExit setHidden:!self.user.authorized];
    [footer addSubview:m_btnExit];
    m_tableView.tableFooterView = footer;
}

#pragma mark Table Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.user.authorized) {
        return 4;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (self.user.authorized) {
            NSArray *array=@[@"修改密码",@"意见反馈",@"免责声明",@"版本信息"];
            [cell.textLabel setText:array[indexPath.row]];
            if(indexPath.row == 3) {
                NSString *string=[NSString stringWithFormat:@"v %@",Current_Version];
                [cell.detailTextLabel setText:string];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else {
            NSArray *array=@[@"免责声明",@"版本信息"];
            [cell.textLabel setText:array[indexPath.row]];
            if(indexPath.row == 1) {
                NSString *string=[NSString stringWithFormat:@"v %@",Current_Version];
                [cell.detailTextLabel setText:string];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.user.authorized) {
        if (indexPath.row == 0) {
            RegisterViewController *c = [[RegisterViewController alloc] initWithRestPsw:YES];
            [self presentVC:c];

        }
        else if (indexPath.row == 1) {
            FeedbackViewController *v = [FeedbackViewController alloc];
            v.delegate = self;
            [self showNavigationView:v];
        }
        if (indexPath.row == 2) {
            [self showPolicy];
        }

    } else {
        if (indexPath.row == 0) {
            [self showPolicy];
        }
    }
}

- (void)showPolicy {
    WebHtmlViewController *vc = [[WebHtmlViewController alloc] initWithTitle:@"免责声明" withUrl:@"http://h5.chijidun.com/disclaimer.html"];
    [self showNavigationView:vc];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.5f;
}

- (void)didSubmitFeedback:(FeedbackViewController *)controller {
    [self.view showHUD:@"反馈成功，我们会尽快处理"];
    [controller dismissViewControllerAnimated:YES completion:nil];
}


- (void)btnLoginOutTapped:(id)sender {
    UserLoginOutRequest *request = [UserLoginOutRequest new];
    [cgClient disableAfterRequest];
    [cgClient doUserLoginOut:request success:^(CGResponse *data, NSString *url) {
        UserLoginOutResponse *response=[[UserLoginOutResponse alloc]initWithCGResponse:data];
        NSLog(@"%@",response.data);
        [[App shared] setUser:nil];
        [[App shared]save];
        [[App shared] setCurrentUser:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        NSNotification *notification =[NSNotification notificationWithName:@"loginOut" object:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
}


@end
