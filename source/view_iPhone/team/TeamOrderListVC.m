//
//  TeamOrderListVC.m
//  chijidun
//
//  Created by iMac on 16/9/21.
//
//

#import "TeamOrderListVC.h"

@interface TeamOrderListVC ()
{
    TeamOrderListView *m_mainView;
    TeamUnjoinView *m_unJoinView;
    
    BOOL _isFirst;
    
    UIButton *m_rightBtn;
}
@end

@implementation TeamOrderListVC
- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self loadCompany];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"企业团餐";
    m_rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 20)];
    [m_rightBtn setTitle:@"团餐订单" forState:UIControlStateNormal];
    [m_rightBtn.titleLabel setFont:[UIFont LightFontOfSize:16]];
    [m_rightBtn addTarget:self action:@selector(rightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:m_rightBtn];
    
    _isFirst=YES;
    m_mainView=[[TeamOrderListView alloc]init];
    __block __typeof(self)weakSelf = self;
    m_mainView.refreshBlock=^(){
        [weakSelf loadOrderLists];
    };
    m_unJoinView=[[TeamUnjoinView alloc]init];
}
-(void)viewDidDisappear:(BOOL)animated
{
    _isFirst=NO;
}
-(void)loadCompany
{
    HasCompanyMealRequest *request = [HasCompanyMealRequest new];
    [cgClient disableAfterRequest];
    [cgClient hideProgress];
    [cgClient doHasCompanyMeal:request success:^(CGResponse *data, NSString *url) {
        HasCompanyResponse *response=[[HasCompanyResponse alloc]initWithCGResponse:data];
        if (response.has.intValue==1) {
            if (response.status.intValue==0) {
                self.view=m_mainView;
                [self loadOrderLists];
                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:m_rightBtn];
            }else{
                m_unJoinView.hasCompany=response;
                [m_unJoinView reloadViews];
                self.view=m_unJoinView;
                self.navigationItem.rightBarButtonItem=nil;
            }
        }else{
            m_unJoinView.hasCompany=response;
            [m_unJoinView reloadViews];
            self.view=m_unJoinView;
            self.navigationItem.rightBarButtonItem=nil;
        }
    }failure:^(CGResponse *data, NSString *url) {
        [self.view showHUD:data.result];        
        if ([data.code intValue]==1000) {
            [[App shared] setUser:nil];
            [[App shared]save];
            [[App shared] setCurrentUser:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentVC:[LoginViewController new]];
            });
        }
    }];
}
-(void)loadOrderLists
{
    TeamOrderIndexRequest *request = [TeamOrderIndexRequest new];
    [cgClient hideProgress];
    [cgClient doTeamOrderIndex:request success:^(CGResponse *data, NSString *url) {
        TeamOrderIndexResponse *response=[[TeamOrderIndexResponse alloc]initWithCGResponse:data];
        self.title=response.company.short_name;
        m_mainView.lists=response.lists;
        [m_mainView reloadDatasWith:_isFirst];
    }];
}
-(void)rightBarButtonClick
{
    [[App shared] restore];
    USER *user = [[App shared] currentUser];
    if (user.token.length==0) {
        [self presentVC:[LoginViewController new]];
    }else{
        [self showNavigationView:[TeamOrdersViewController new]];
    }
}
@end




