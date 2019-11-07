//
//  TeamOrdersViewController.m
//  chijidun
//
//  Created by iMac on 16/10/13.
//
//

#import "TeamOrdersViewController.h"
#define TeamOrderCellSmallIdentify @"TeamOrderCellSmall"
#define TeamOrderCellBigIdentify @"TeamOrderCellBig"
#define Button_WIDTH 100
#define Button_HEIGHT 45

@interface TeamOrdersViewController ()
{
    UITableView *m_tableView;
    
    UIButton *m_btnType;
    UIImageView *m_backView;
    NSMutableArray *m_arrayBtns;
    
    int _currentPage;
    NSInteger _type;
    NSMutableArray *m_arrayList;
    
    UIView *m_footer;
}
@end

@implementation TeamOrdersViewController
-(void)viewDidAppear:(BOOL)animated
{
    [self loadOrderData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    self.view.backgroundColor=getUIColor(0xf8f8f8);
    
    _currentPage=1;
    m_arrayList=[NSMutableArray array];
    [self loadOrderData];
    [self addMainView];
    m_btnType=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 36)];
    [m_btnType setTitle:@"团餐订单" forState:UIControlStateNormal];
    [m_btnType setImage:[UIImage imageNamed:@"team_down"] forState:UIControlStateNormal];
    [m_btnType setTitleColor:getUIColor(0x0099ff) forState:UIControlStateNormal];
    [m_btnType.titleLabel setFont:[UIFont LightFontOfSize:17]];
    self.navigationItem.titleView=m_btnType;
    [m_btnType setImageEdgeInsets:UIEdgeInsetsMake(12, 78, 12, 0)];
    [m_btnType setTitleEdgeInsets:UIEdgeInsetsMake(0, -32, 0, 10)];
    [m_btnType addTarget:self action:@selector(showTypeView) forControlEvents:UIControlEventTouchUpInside];
    
    if (m_emptyView==nil) {
        m_emptyView=[[EmptyView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
        [m_emptyView setImage:@"order-empty" Title:@"暂无订单" SubTitle:nil];
        [self.view addSubview:m_emptyView];
    }
    [m_emptyView setHidden:YES];
}
-(void)addMainView
{
    [self.view.layer addSublayer:getLine(0, kMainScreen_Width, 1, 1, BORDER_COLOR)];
    
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 1, kMainScreen_Width, kMainScreen_Height-NAV_HEIGHT)];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    [self.view addSubview:m_tableView];
    m_tableView.backgroundColor=getUIColor(0xf8f8f8);
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [m_tableView registerNib:[UINib nibWithNibName:TeamOrderCellSmallIdentify bundle:nil] forCellReuseIdentifier:TeamOrderCellSmallIdentify];
    [m_tableView registerNib:[UINib nibWithNibName:TeamOrderCellBigIdentify bundle:nil] forCellReuseIdentifier:TeamOrderCellBigIdentify];
    
    @weakify(self)
    m_tableView.mj_header = refresh_header1;
    self.refreshBlock = ^{
        @strongify(self)
        _currentPage=1;
        [self loadOrderData];
        [m_tableView.mj_header endRefreshing];
    };
    m_tableView.mj_header.automaticallyChangeAlpha = YES;
    m_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _currentPage++;
        [self loadOrderData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [m_tableView.mj_footer endRefreshing];
        });
    }];

    
    m_footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 100)];
    //CGFloat left=(kMainScreen_Width-100)/2;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, kCart_HEIGHT, kMainScreen_Width, 20)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"——· 没有更多了 ·——"];
    [label setFont:[UIFont LightFontOfSize:15]];
    [label setTextColor:BORDER_COLOR];
    [m_footer addSubview:label];
    
    self.navigationController.view.clipsToBounds=NO;
    CGFloat backleft=(kMainScreen_Width-110)/2;
    m_backView=[[UIImageView alloc]initWithFrame:CGRectMake(backleft, 54, 110, 198)];
    [m_backView setImage:[UIImage imageNamed:@"team_kuang"]];
    [self.navigationController.view addSubview:m_backView];
    m_backView.hidden=YES;
    m_backView.userInteractionEnabled=YES;
    
    NSArray  *array=@[@"全部",@"早餐",@"午餐",@"晚餐"];
    m_arrayBtns=[NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        UIButton *button=[[UIButton alloc]init];
        [button setFrame:CGRectMake(5, 11+i*Button_HEIGHT, Button_WIDTH, Button_HEIGHT)];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont LightFontOfSize:15]];
        [button setTitleColor:TEXT_DEEP forState:UIControlStateNormal];
        [button setTitleColor:WHITE_COLOR forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageWithColor:WHITE_COLOR] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:MAIN_COLOR] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageWithColor:WHITE_COLOR] forState:UIControlStateHighlighted];
        button.tag=i;
        [button addTarget:self action:@selector(buttonTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [m_backView addSubview:button];
        if (i<array.count) {
            [button.layer addSublayer:getLine(0, Button_WIDTH, Button_HEIGHT, Button_HEIGHT, BORDER_COLOR)];
        }
        [m_arrayBtns addObject:button];
    }
}
-(void)showTypeView
{
    if (m_backView.hidden) {
        [m_backView setHidden:NO];
        m_tableView.userInteractionEnabled=NO;
        [m_btnType setImage:[UIImage imageNamed:@"team_up"] forState:UIControlStateNormal];
    }else{
        [m_backView setHidden:YES];
        m_tableView.userInteractionEnabled=YES;
        [m_btnType setImage:[UIImage imageNamed:@"team_down"] forState:UIControlStateNormal];
    }
}
-(void)buttonTypeClicked:(UIButton *)button
{
    for (NSInteger i = 0; i < m_arrayBtns.count; i ++) {
        UIButton *btn=m_arrayBtns[i];
        if (i == button.tag) {
            _type=button.tag;
            _currentPage=1;
            [btn setSelected:YES];
            [self loadOrderData];
        }else{
            [btn setSelected:NO];
        }
    }
}
-(void)loadOrderData
{
    AccountOrderRequest *request = [AccountOrderRequest new];
    request.page=[NSString stringWithFormat:@"%d",_currentPage];
    request.limit=@"10";
    request.mealType=[NSString stringWithFormat:@"%ld",(long)_type];
    [cgClient hideProgress];
    [cgClient doAccountOrder:request success:^(CGResponse *data, NSString *url) {
        AccountOrderResponse *response=[[AccountOrderResponse alloc]initWithCGResponse:data];
        if (_currentPage>1) {
            [m_arrayList addObjectsFromArray:response.orderList];
        }else{
            m_arrayList=[NSMutableArray arrayWithArray:response.orderList];
        }
        if (m_arrayList.count==0) {
            [m_emptyView setHidden:NO];
        }else{
            [m_emptyView setHidden:YES];
        }
        if (response.isLast) {
            m_tableView.tableFooterView=m_footer;
            [m_tableView.mj_footer setHidden:YES];
            [m_tableView.mj_footer endRefreshing];
        }else{
            m_tableView.tableFooterView=nil;
            [m_tableView.mj_footer setHidden:NO];
            [m_tableView.mj_footer endRefreshing];
        }
        
        if (!m_backView.hidden) {
            [self showTypeView];
        }
        [m_tableView reloadData];
    }];
}

#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_arrayList.count;
}
#pragma mark tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamOrderTable *order=m_arrayList[indexPath.row];
    if (order.status.intValue==0||(order.status.intValue==1&&order.cancel.intValue==1)) {
        return 185;
    }
    return 135;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    TeamOrderTable *order=m_arrayList[indexPath.row];
    if (order.status.intValue==0||(order.status.intValue==1&&order.cancel.intValue==1)) {
        TeamOrderCellBig *_cell = (TeamOrderCellBig *)[tableView dequeueReusableCellWithIdentifier:TeamOrderCellBigIdentify forIndexPath:indexPath];
        _cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [_cell bindWith:m_arrayList[indexPath.row]];
        
        __block __typeof(self)weakSelf = self;
        _cell.payBlock = ^(TeamOrderTable *item)
        {
            [weakSelf payOrderWith:item];
        };
        _cell.cancelBlock = ^(TeamOrderTable *item)
        {
            [weakSelf cancelOrderWith:item];
        };
        _cell.timerEndBlock = ^()
        {
            [weakSelf loadOrderData];
        };
        
        cell=_cell;
    }else{
        TeamOrderCellSmall *_cell = (TeamOrderCellSmall *)[tableView dequeueReusableCellWithIdentifier:TeamOrderCellSmallIdentify forIndexPath:indexPath];
        _cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [_cell bindWith:m_arrayList[indexPath.row]];
        cell=_cell;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TeamOrderTable *order=m_arrayList[indexPath.row];
    TeamOrderDetailViewController *detailVC=[[TeamOrderDetailViewController alloc]init];
    detailVC.orderId=order.order_id;
    detailVC.goLastVC=YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)cancelOrderWith:(TeamOrderTable *)order
{
    DeleteOrderRequest *request = [DeleteOrderRequest new];
    request.orderId=order.order_id;
    [cgClient doDeleteOrder:request success:^(CGResponse *data, NSString *url) {
        [self.view showHUD:@"取消成功"];
        [self loadOrderData];
    }];
}

-(void)payOrderWith:(TeamOrderTable *)order
{
    TeamOrderPayVC *payVC=[[TeamOrderPayVC alloc]init];
    payVC.orderId=order.order_id;
    payVC.goLastVC=YES;
    [self.navigationController pushViewController:payVC animated:YES];
}
@end





