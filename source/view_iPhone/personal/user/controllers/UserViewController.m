#import "UserViewController.h"
#import "UIImageView+Extend.h"

#define kIconWidth 90.0
#define ImageHight kMainScreen_Width*3/4

@interface UserViewController () {
    UIImageView *m_iconView;
    UILabel *m_labName;
    NSString *m_hotLine;

    NSString *m_replyNum;
    
    UILabel *m_lab3;
    UILabel *m_lab4;
    BOOL _getFailure;
    
    UIImageView *m_zoomImageView;
    UserButton *_buttonOrder;
    UIButton *m_buttonSet;
}
@end
@implementation UserViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    if (!ISLoadedUserInfo) {
        [[App shared] restore];
        self.user = [[App shared] currentUser];
    }
    if (self.user.authorized) {
       [[AppDelegate appDelegate] setTabNumWith:@""];
       [self loadUserData];
       [self loadData];
    }else{
        [m_lab3 setHidden:YES];
        [m_lab4 setHidden:YES];
        [[AppDelegate appDelegate] setTabNumWith:@""];
        m_iconView.image = [UIImage imageNamed:@"user_unlogin"];
        [m_iconView click:self action:@selector(showLoginView)];
        [m_labName click:self action:@selector(showLoginView)];
        [m_labName setText:@"登录/注册"];
    }
}
-(void)loadUserData
{
    UserGetRequest *request=[UserGetRequest new];
    [apiClient doUserGet:request success:^(NSMutableDictionary *_data, NSString *_url) {
        UserGetResponse *response=[[UserGetResponse new]fromJSON:_data];
        [App shared].user = response.data;
        [[App shared] save];
        [[App shared] restore];
        self.user = [[App shared] currentUser];
        if (!self.user.user_id) {
            m_iconView.image = [UIImage imageNamed:@"user_unlogin"];
            [m_iconView click:self action:@selector(showLoginView)];
            [m_labName click:self action:@selector(showLoginView)];
            [m_labName setText:@"登录/注册"];
        } else {
            if (self.user.authorized) {
                [m_iconView load:self.user.avatarimg];
                m_labName.text = self.user.name;
                [m_iconView click:self action:@selector(userEditor)];
                [m_labName click:self action:@selector(userEditor)];
            }
        }
    }failure:^(NSMutableDictionary *data, NSString *url) {
        [[App shared] setUser:nil];
        [[App shared]save];
        [[App shared] setCurrentUser:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backend = [UserBackend new];
    [self setTableView];
    m_hotLine = @"0571-89021860";
    
}
-(void)loadData
{
    UserMemberReplyUncheckCountRequest *request = [UserMemberReplyUncheckCountRequest new];
    [apiClient doUserMemberReplyUncheckCount:request success:^(NSMutableDictionary *data, NSString *url) {
        UserMemberReplyUncheckCountResponse *response = [[UserMemberReplyUncheckCountResponse new] fromJSON:data];
        m_replyNum=response.data.count;
        if (m_replyNum.intValue>0) {
            [m_lab3 setHidden:NO];
            [m_lab4 setHidden:NO];
        }else{
            [m_lab3 setHidden:YES];
            [m_lab4 setHidden:YES];
        }
        [[AppDelegate appDelegate] setTabNumWith:m_replyNum];
        [self.mainTableView reloadData];
    }];
}
- (void)setTableView
{
    self.mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height-kNAV_HEIGHT)];
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.backgroundColor = BG_COLOR;
    self.mainTableView.contentInset = UIEdgeInsetsMake(ImageHight, 0, 0, 0);
    [self.view addSubview:self.mainTableView];
    
    
    m_zoomImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -ImageHight, self.view.frame.size.width, ImageHight)];
    [m_zoomImageView setImage:[UIImage imageNamed:@"user_back"]];
    m_zoomImageView.userInteractionEnabled=YES;
    m_zoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.mainTableView addSubview:m_zoomImageView];
    m_zoomImageView.autoresizesSubviews = YES;
    
    m_iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kIconWidth, kIconWidth)];
    m_iconView.center = CGPointMake(kMainScreen_Width * 0.5,  ImageHight- 140-kIconWidth/2);
    [m_iconView setImage:[UIImage imageNamed:@"user_unlogin"]];
    m_iconView.layer.cornerRadius = kIconWidth * 0.5;
    m_iconView.layer.masksToBounds = YES;
    m_iconView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    m_labName = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreen_Width * 0.3, CGRectGetMaxY(m_iconView.frame)+kDistanceMin, kMainScreen_Width * 0.4, 20)];
    [m_labName setTextAlignment:NSTextAlignmentCenter];
    [m_labName setTextColor:WHITE_COLOR];
    m_labName.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    [m_zoomImageView addSubview:m_iconView];
    [m_zoomImageView addSubview:m_labName];
    
    m_buttonSet = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreen_Width -48, 20, 38, 38)];
    [m_buttonSet setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [m_buttonSet setImage:[UIImage imageNamed:@"icon-setup-white"] forState:UIControlStateNormal];
    [m_buttonSet addTarget:self action:@selector(buttonSetClicked:) forControlEvents:UIControlEventTouchUpInside];
    m_buttonSet.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [m_zoomImageView addSubview:m_buttonSet];
    
    
    CGFloat width=kMainScreen_Width/3;
    CGFloat height=90;
    NSArray *arrayTitle=@[@"我的订单",@"收货地址",@"我的收藏"];
    
    for (int i=0; i<3; i++) {
        UserButton *button=[[UserButton alloc]initWithFrame:CGRectMake(width*i, ImageHight-height, width, height)];
        [button setDataWith:arrayTitle[i] and:@"0"];
        button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i;
        [m_zoomImageView addSubview:button];
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    if (y < -ImageHight) {
        CGRect frame = m_zoomImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;
        m_zoomImageView.frame = frame;
    }
}

#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    if (section==2) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kDistance;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}
#pragma mark tableview datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentify = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    
    UIImageView *imageView;
    UILabel *labTitle;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 16, 18, 18)];
        labTitle=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+kDistance, 0, 80, 50)];
    }
    NSArray *imgList= @[@[@"user_comment",@"user_coupon",@"user_score"], @[@"user_cook"],@[@"user_phone",@"user_about"]];
    imageView.image = [UIImage imageNamed:imgList[indexPath.section][indexPath.row]];
    [cell.contentView addSubview:imageView];
    
    NSArray *arrayList= @[@[@"我的评价",@"我的红包",@"我的积分"],@[ @"我要做饭"],@[@"客服电话", @"关于我们"]];
    [labTitle setFont:[UIFont LightFontOfSize:17]];
    [labTitle setTextColor:TEXT_MIDDLE];
    [labTitle setText:arrayList[indexPath.section][indexPath.row]];
    [cell.contentView addSubview:labTitle];

    if (indexPath.section==0&&indexPath.row==0) {
        if (m_replyNum.intValue>0&&self.user.authorized) {
            if (m_lab4==nil) {
                m_lab4=[[UILabel alloc]initWithFrame:CGRectMake(kMainScreen_Width-30-18, 16, 18, 18)];
                [m_lab4 setTextAlignment:NSTextAlignmentCenter];
                [m_lab4 setTextColor:WHITE_COLOR];
                [m_lab4 setBackgroundColor:[UIColor redColor]];
                m_lab4.layer.cornerRadius=10.0f;
                m_lab4.layer.masksToBounds=YES;
                [m_lab4 setFont:[UIFont LightFontOfSize:13]];
            }
            if (m_lab3==nil) {
                m_lab3=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(m_lab4.frame)-80, 0, 75, 50)];
                [m_lab3 setFont:[UIFont LightFontOfSize:15]];
                [m_lab3 setTextAlignment:NSTextAlignmentRight];
                [m_lab3 setTextColor:TEXT_MIDDLE];
            }
            if (m_replyNum.intValue>99) {
                CGFloat width=getTextSize(m_replyNum, kMainScreen_Width, [UIFont LightFontOfSize:13]).width+10;
                [m_lab4 setFrame:CGRectMake(kMainScreen_Width-30-width, 16, width, 18)];
                [m_lab3 setFrame:CGRectMake(CGRectGetMinX(m_lab4.frame)-80, 0, 75, 50)];
            }
            
            [m_lab3 setText:@"私厨回复"];
            [m_lab4 setText:m_replyNum];
            [cell.contentView addSubview:m_lab3];
            [cell.contentView addSubview:m_lab4];
        }
    }
    if (indexPath.section==2&&indexPath.row == 0) {
        [cell.detailTextLabel setFont:[UIFont LightFontOfSize:15]];
        [cell.detailTextLabel setTextColor:BLUE_COLOR];
        
        [cell.detailTextLabel setText:m_hotLine];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (MODEL_VERSION >= 7.0) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 18, 0, 0)];
        }
        if (MODEL_VERSION >= 8.0) {
            if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
                [cell setPreservesSuperviewLayoutMargins:NO];
            }
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:UIEdgeInsetsMake(0, 18, 0, 0)];
            }
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    if (indexPath.section==0) {
        ISLoadedUserInfo=YES;
        if (self.user.authorized) {
            if (indexPath.row == 0) {
                MyCommentsViewController *comment=[[MyCommentsViewController alloc]init];
                comment.replyNum=m_replyNum;
                [self showNavigationView:comment];
            }
            if (indexPath.row == 1) {
                CouponController *uc=[[CouponController alloc] init];
                [self showNavigationView:uc];
            }
            if (indexPath.row == 2) {
                ScoreViewController *uc=[[ScoreViewController alloc] init];
                [self showNavigationView:uc];
            }
        }else{
            [self showLoginView];
        }
        
    }
    if (indexPath.section==1) {
        [self showNavigationView:[[WebHtmlViewController alloc]initWithTitle:@"我要做饭" withUrl:@"http://h5.chijidun.com/sichu.html"]];
    }
    if (indexPath.section == 2) {
        if (indexPath.row==0) {            
            CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:m_hotLine andMessage:nil];
            view.animationType = AnimationTypeBigToSmall;
            view.titleTextColor = TEXT_DEEP;
            [view addButtonWithTitle:@"取消" color:BLUE_COLOR handler:^(CBWAlertView *alertView){
            }];
            [view addButtonWithTitle:@"呼叫" color:BLUE_COLOR handler:^(CBWAlertView *alertView) {
                NSString *urlString = [NSString stringWithFormat:@"tel://057189021860"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }];
            [view show];
        }
        if (indexPath.row==1) {
            [self showNavigationView:[[WebHtmlViewController alloc]initWithTitle:@"关于我们" withUrl:@"http://h5.chijidun.com/about.html"]];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 10)];
    [footer setBackgroundColor:[UIColor clearColor]];
    return footer;
}


- (void)userEditor {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    if (self.user.authorized) {
        ISLoadedUserInfo=NO;
        UserEditViewController *uec = [[UserEditViewController alloc] init];
        uec.delegate = self;
        uec.userImg = self.user.avatarimg;
        [self showNavigationView:uec];
    } else {
        [self showLoginView];
    }
}

- (void)showLoginView {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    ISLoadedUserInfo=NO;
    LoginViewController *c = [LoginViewController new];
    [self presentVC:c];
}
-(void)buttonClicked:(UserButton *)button
{
    if (self.user.authorized) {
        ISLoadedUserInfo=YES;
        if (button.tag==0) {
            OrderListViewController *uc = [[OrderListViewController alloc]init];
            [self showNavigationView:uc];
        }
        if (button.tag==1) {
            UserAddressListViewController *listVC = [[UserAddressListViewController alloc]init];
            [self showNavigationView:listVC];
        }
        if (button.tag==2) {
            FavViewController *uc=[[FavViewController alloc] init];
            uc.TabbarController=(TabBarController *) self.parentViewController;
            [self showNavigationView:uc];
        }
    } else {
        [self showLoginView];
    }

}
-(void)buttonSetClicked:(UIButton *)button
{
    ISLoadedUserInfo = NO;
    UserSettingViewController *uc = [UserSettingViewController new];
    [self showNavigationView:uc];
}
@end




