//
//  FavViewController.m
//  insuny
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "CouponController.h"
#import "CouponTableViewCell.h"

#define FavTableCell @"CouponTableViewCell"

@interface CouponController ()
{
    UITextField *m_codeField;
    UIButton *m_exchangeBtn;
    UIImageView *m_emptyView;
    QuanListsData *quanListsData;
    int page;
    
    
    QuanTable *_quan;
    BOOL _isCheckOut;
}
@end

@implementation CouponController
-(instancetype)initWithCheckOut:(QuanTable *)quan
{
    _isCheckOut=YES;
    _quan=quan;
    return [self init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"我的红包";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    
    page=1;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, kMainScreen_Width, kMainScreen_Height-64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor=getColorWithRGB(242, 242, 242);
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerNib:[UINib nibWithNibName:FavTableCell bundle:nil]  forCellReuseIdentifier:FavTableCell];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = refresh_header1;
    @weakify(self)
    self.refreshBlock = ^{
        @strongify(self)
        page=1;
        [self loadTicketData];
        [self.tableView.mj_header endRefreshing];
    };

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadTicketDataMore];
        [self.tableView.mj_footer endRefreshing];
    }];

    [self.view addSubview:self.tableView];
    
    m_emptyView=[[UIImageView alloc]initWithFrame:CGRectMake(kMainScreen_Width*0.2, kMainScreen_Height*0.2, kMainScreen_Width*0.6, kMainScreen_Width*0.81)];
    [m_emptyView setImage:[UIImage imageNamed:@"noticket"]];
    [self.tableView addSubview:m_emptyView];
    [m_emptyView setHidden:YES];
    
    if (!_isCheckOut) {
        self.tableView.allowsSelection = NO;
        [self addTableHeaderView];
    }
    [self loadTicketData];
}
-(void)addTableHeaderView
{
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kCellHeight*5/4)];
    self.tableView.tableHeaderView=header;
    
    m_codeField=[[UITextField alloc]initWithFrame:CGRectMake(kMainScreen_Width*0.05, 10, kMainScreen_Width*0.7, kCellHeight)];
    UIView *sview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, kCellHeight)];
    m_codeField.leftView=sview;
    m_codeField.leftViewMode=UITextFieldViewModeAlways;
    m_codeField.placeholder=@"请输入兑换码，领红包";
    m_codeField.returnKeyType=UIReturnKeyDone;
    [m_codeField setBackgroundColor:WHITE_COLOR];
    m_codeField.layer.cornerRadius=5.0f;
    m_codeField.delegate=self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange)name:UITextFieldTextDidChangeNotification object:m_codeField];
    [header addSubview:m_codeField];
    
    m_exchangeBtn=[[UIButton alloc]initWithFrame:CGRectMake(kMainScreen_Width*0.8, 10, 60, kCellHeight)];
    [m_exchangeBtn setBackgroundColor:MAIN_COLOR];
    [m_exchangeBtn setTitle:@"兑换" forState:UIControlStateNormal];
    m_exchangeBtn.layer.cornerRadius=5.0f;
    [m_exchangeBtn addTarget:self action:@selector(exchangeCode:) forControlEvents:UIControlEventTouchUpInside];
    m_exchangeBtn.enabled=NO;
    [header addSubview:m_exchangeBtn];
}
-(void)loadTicketData
{
    QuanListsRequest *request = [QuanListsRequest new];
    if (_isCheckOut) {
        request.used_uid=@"0";
        request.order_user=@"order";
    }
    [apiClient doQuanLists:request success:^(NSMutableDictionary *data, NSString *url) {
        QuanListsResponse *response = [[QuanListsResponse new] fromJSON:data];
        quanListsData=response.data;
        if (quanListsData.list.count>0) {
            [self.tableView reloadData];
        }else{            
            [m_emptyView setHidden:NO];
        }
    }];
}
-(void)loadTicketDataMore
{
    page++;
    QuanListsRequest *request = [QuanListsRequest new];
    request.page=[NSString stringWithFormat:@"%d",page];
    if (_isCheckOut) {
        request.used_uid=@"0";
        request.order_user=@"order";
    }
    [apiClient doQuanLists:request success:^(NSMutableDictionary *data, NSString *url) {
        QuanListsResponse *response = [[QuanListsResponse new] fromJSON:data];
        NSDictionary *dict=data[@"data"][@"pageInfo"];
        int totalPage=[[dict objectForKey:@"totalPage"] intValue];
        if (page<=totalPage) {
            [quanListsData.list addObjectsFromArray:response.data.list];
            [self.tableView reloadData];
        }
    }];
}
-(void)textChange
{
    m_exchangeBtn.enabled= m_codeField.text.length>0;
}
#pragma mark Table Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return quanListsData.list.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponTableViewCell *cell = (CouponTableViewCell *)[tableView dequeueReusableCellWithIdentifier:FavTableCell forIndexPath:indexPath];
    QuanTable *quan=quanListsData.list[indexPath.row];
    [cell bindWith:quan];
    if (_isCheckOut) {
        if ([quan.Id isEqualToString:_quan.Id]) {
            [cell.selectTicketView setHidden:NO];
        }else{
            [cell.selectTicketView setHidden:YES];
        }
    }else{
        [cell.selectTicketView setHidden:YES];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_isCheckOut) {
        CouponTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        if (cell.selectTicketView.hidden) {
            _quan=quanListsData.list[indexPath.row];
        }else{
            _quan=nil;
        }
        [self.tableView reloadData];
        if (self.selectBlock) {
            self.selectBlock(_quan);
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self goBack];
        });
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCellHeight;
}
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kCellHeight)];
    if (quanListsData.list.count>0) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(kMainScreen_Width*0.05, 10, kMainScreen_Width*0.5, 20)];
        [label setText:@"*红包一次只能使用一张"];
        [label setFont:FONT_DEFAULT15];
        [label setTextColor:COLOR_MID_GRAY];
        [view addSubview:label];
    }
    return view;
}
#pragma mark action
-(void)exchangeCode:(UIButton *)button
{
    [m_codeField resignFirstResponder];
    QuanExchange_quanRequest *request = [QuanExchange_quanRequest new];
    request.code=m_codeField.text;
    [apiClient doQuanExchange_quan:request success:^(NSMutableDictionary *data, NSString *url) {
        QuanExchange_quanResponse *response=[[QuanExchange_quanResponse new] fromJSON:data];
        [self.view showHUD:@"兑换成功"];
        QuanExchange_quanData *quanData=response.data;
        [self getTicketDetailWith:quanData.Id];
    }];
}
-(void)getTicketDetailWith:(NSString *)Id
{
    QuanGetRequest *request = [QuanGetRequest new];
    request.Id=Id;
    [apiClient doQuanGet:request success:^(NSMutableDictionary *data, NSString *url) {
        QuanGetResponse *response=[[QuanGetResponse new] fromJSON:data];
        [quanListsData.list addObject:response.data];
        if (quanListsData.list.count>0) {
            [m_emptyView setHidden:YES];
        }
        [self.tableView reloadData];
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end



