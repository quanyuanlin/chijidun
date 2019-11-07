//
//  TeamOrderDetailVC.m
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import "TeamOrderDetailVC.h"
#define ChefItemHeaderIdentify @"ChefItemHeaderCell"
#define ChefItemCellIdentify @"ChefItemCell"
#define TeamOrderCellIdentify @"TeamOrderCell"

#define kLeftWidth 45
#define kHeaderHeight 154
#define BtnHeight 40
#define BtnWidth 35
#define BtnOrderWidth S(120)
#define BtnOrderHeight 50
#define BtnCartSize 50
#define LabCartSize 22
#define TotalWidth 150
@interface TeamOrderDetailVC ()
{
    UILabel *m_labMonth;
    
    TeamWeekView *m_weekView;
    UIView *m_headerView;
    UIView *m_leftView;
    UIView *m_footerView;
    UITableView *m_tableView;
    UIScrollView *m_scrollView;
    UITableView *m_tableView2;
    TeamCartView *m_cartView;
    
    NSMutableArray *m_headerBtns;
    NSMutableArray *m_leftArrays;
    NSMutableArray *m_leftBtns;
    NSDictionary *_dictData;
    NSMutableArray *m_arrTypes;
    
    OrderTimeIntervalTable *_item;
    
    UIButton *m_btnCart;
    UILabel *m_labCart;
    UIButton *m_btnOrder;
    UILabel *m_labTotal;
    UILabel *m_labEmpty;
    BOOL _isShow;
    
    GetMembersAndOrderResponse *_responseData;
    NSString *_mealType;
    
    NSArray *m_chefLists;
    TeamOrderTable *_order;
    NSInteger _leftTag;
    NSInteger _selectLeftTag;
    NSString *_selectTitle;
    
    UILabel *m_labTotalMoney;
    UILabel *m_labStatus;
    EmptyView *m_emptyView;
    NSArray *_leftArray;
    
    NSMutableArray *m_arrayCart;
    
    NSString *_foodType;
    int _currentPage;
    
    BOOL _backConfirm;
    TeamFoodDetailView *m_detailView;
    BOOL _isShowDetilView;
    UILabel *m_labelTitle;
}
@end

@implementation TeamOrderDetailVC
-(void)viewDidAppear:(BOOL)animated
{
    if (!_backConfirm) {
        [self loadTimeInterval];
        //[self headReloadWith:_item];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    self.view.backgroundColor=getUIColor(0xf8f8f8);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date= [dateFormatter dateFromString:_index.ymd];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
    if (week==1) {
        NSDate *date2 = [dateFormatter dateFromString:_index.ymd];
        NSDate *date=[NSDate date];
        [dateFormatter setDateFormat:@"dd"];
        NSString * day0String = [dateFormatter stringFromDate:date];
        NSString * day2String = [dateFormatter stringFromDate:date2];
        if ((day2String.intValue-day0String.intValue)>0) {
            _currentPage=1;
        }
    }
       
    _dictData = @{@"1":@"早餐",
                  @"2":@"午餐",
                  @"3":@"晚餐"
                  };
    _foodType=_index.type;
    [self addSiderView];
    [self loadTimeInterval];
    m_arrayCart=[NSMutableArray array];
    [self reloadCart];
}
-(void)setNavigationBar
{
    UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, NAV_HEIGHT)];
    [titleView setBackgroundColor:NAVI_COLOR];
    [self.view addSubview:titleView];
    
    
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, 60, 40)];
    UIImageView *iconBack=[[UIImageView alloc]initWithFrame:CGRectMake(kDistance, kDistance, 16, 16)];
    [iconBack setImage:[UIImage imageNamed:@"icon-back-left"]];
    [leftView addSubview:iconBack];
    
    m_labMonth=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconBack.frame)+5, kDistance, 35, 16)];
    [m_labMonth setTextColor:TEXT_DEEP];
    [m_labMonth setFont:[UIFont LightFontOfSize:16]];
    [leftView addSubview:m_labMonth];
    [titleView addSubview:leftView];
    [leftView click:self action:@selector(goBack)];
    
    CGFloat orginX=(kMainScreen_Width-150)/2;
    m_labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(orginX, 30, 150, 20)];
    [m_labelTitle setTextColor:TEXT_DEEP];
    [m_labelTitle setFont:[UIFont LightFontOfSize:18]];
    [m_labelTitle setTextAlignment:NSTextAlignmentCenter];
    [titleView addSubview:m_labelTitle];
    
    
    UIButton *setBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreen_Width-35, 30, 18, 18)];
    [setBtn setImage:[UIImage imageNamed:@"icon-setup"] forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(rightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:setBtn];
}
-(void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)rightBarButtonClick
{
    TeamSetViewController *setVC=[[TeamSetViewController alloc]init];
    [self showNavigationView:setVC];
}
-(void)addSiderView
{
    m_weekView=[[TeamWeekView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, kMainScreen_Width, kCart_HEIGHT)];
    __block __typeof(self)weakSelf = self;
    m_weekView.date=_index.ymd;
    m_weekView.indexBlock=^(OrderTimeIntervalTable *item){
        [m_labMonth setText:[NSString stringWithFormat:@"%@月",item.month]];
        _foodType=item.list[0];
        [weakSelf headReloadWith:item];
    };
    m_weekView.swipeBlock=^(BOOL isRight){
        if (isRight) {
            _currentPage++;
        }else{
            _currentPage--;
        }
        [weakSelf loadTimeInterval];
    };
    [self.view addSubview:m_weekView];
    
    m_headerView=[[UIView alloc]initWithFrame:CGRectMake(kLeftWidth, CGRectGetMaxY(m_weekView.frame), kMainScreen_Width, 40)];
    [self.view addSubview:m_headerView];
    
    m_leftView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(m_headerView.frame),kLeftWidth , H(self.view)-2*kCart_HEIGHT-40)];
    [self.view addSubview:m_leftView];
    
    if (m_emptyView==nil) {
        m_emptyView=[[EmptyView alloc]initWithFrame:CGRectMake(kLeftWidth, kHeaderHeight, kMainScreen_Width-kLeftWidth, kMainScreen_Height-kHeaderHeight-kCart_HEIGHT)];
        [m_emptyView setImage:@"order-empty" Title:@"暂无订单" SubTitle:nil];
        [self.view addSubview:m_emptyView];
    }
    [m_emptyView setHidden:YES];
    
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(kLeftWidth, kHeaderHeight, kMainScreen_Width-kLeftWidth, kMainScreen_Height-kHeaderHeight-kCart_HEIGHT)];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [m_tableView setBackgroundColor:WHITE_COLOR];
    [m_tableView registerNib:[UINib nibWithNibName:ChefItemCellIdentify bundle:nil] forCellReuseIdentifier:ChefItemCellIdentify];
    //[m_tableView registerNib:[UINib nibWithNibName:TeamOrderCellIdentify bundle:nil] forCellReuseIdentifier:TeamOrderCellIdentify];
    [self.view addSubview:m_tableView];
    [m_tableView setHidden:YES];

    m_scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(kLeftWidth, kHeaderHeight, kMainScreen_Width-kLeftWidth, kMainScreen_Height-kHeaderHeight)];
    [m_scrollView setContentSize:CGSizeMake(W(m_scrollView), kMainScreen_Height)];
    m_scrollView.showsVerticalScrollIndicator = YES;
    [m_scrollView setBackgroundColor:WHITE_COLOR];
    [self.view addSubview:m_scrollView];
    
    m_tableView2=[[UITableView alloc]initWithFrame:CGRectMake(kDistanceMin, kDistanceMin, W(m_scrollView)-2*kDistanceMin, CGFLOAT_MIN)];
    m_tableView2.layer.cornerRadius=5.0f;
    m_tableView2.layer.borderWidth=1.0f;
    m_tableView2.layer.borderColor=getUIColor(0xdddddd).CGColor;
    m_tableView2.scrollEnabled=NO;
    m_tableView2.delegate=self;
    m_tableView2.dataSource=self;
    [m_tableView2 registerNib:[UINib nibWithNibName:TeamOrderCellIdentify bundle:nil] forCellReuseIdentifier:TeamOrderCellIdentify];
    [m_scrollView addSubview:m_tableView2];
    [m_tableView2 click:self action:@selector(showDetailView)];
    
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, W(m_tableView2), kCart_HEIGHT)];
    [footer.layer addSublayer:getLine(20, W(m_tableView2), 0, 0, getUIColor(0xdddddd))];
    m_tableView2.tableFooterView=footer;
    UILabel *labSub=[[UILabel alloc]initWithFrame:CGRectMake(kDistance, 0, 35, kCart_HEIGHT)];
    [labSub setFont:[UIFont LightFontOfSize:17]];
    [labSub setText:@"合计"];
    [footer addSubview:labSub];
    
    m_labTotalMoney=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labSub.frame)+10, 0, 120, kCart_HEIGHT)];
    [m_labTotalMoney setTextColor:getUIColor(0xff5436)];
    [m_labTotalMoney setFont:[UIFont LightFontOfSize:17]];
    [footer addSubview:m_labTotalMoney];
    
    m_labStatus=[[UILabel alloc]initWithFrame:CGRectMake(W(m_tableView2)-kDistance-55, 25/2, 55, 25)];
    m_labStatus.layer.cornerRadius=25/2;
    m_labStatus.layer.masksToBounds=YES;
    [m_labStatus setTextColor:WHITE_COLOR];
    [m_labStatus setBackgroundColor:getUIColor(0x5ccd00)];
    [m_labStatus setFont:[UIFont LightFontOfSize:13]];
    [m_labStatus setTextAlignment:NSTextAlignmentCenter];
    [footer addSubview:m_labStatus];
    
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(kLeftWidth, kMainScreen_Height-kCart_HEIGHT, kMainScreen_Width-kLeftWidth, kCart_HEIGHT)];
    [view setBackgroundColor:WHITE_COLOR];
    [self.view addSubview:view];
    m_footerView=[[UIView alloc]initWithFrame:CGRectMake(0, kMainScreen_Height-kCart_HEIGHT, kMainScreen_Width, kCart_HEIGHT)];
    [m_footerView setBackgroundColor:WHITE_COLOR];
    [m_footerView.layer addSublayer:getLine(0, kMainScreen_Width, 0, 0, getUIColor(0xcccccc))];
    [self.view addSubview:m_footerView];
    
    m_btnCart=[[UIButton alloc]initWithFrame:CGRectMake(2*kDistance, -BtnCartSize*2/5, BtnCartSize, BtnCartSize)];
    [m_btnCart setImage:[UIImage imageNamed:@"icon-cart"] forState:UIControlStateNormal];
    [m_footerView addSubview:m_btnCart];
    m_labCart=[[UILabel alloc]initWithFrame:CGRectMake(BtnCartSize-LabCartSize+5, -3, LabCartSize, LabCartSize)];
    [m_labCart setBackgroundColor:getUIColor(0xff0000)];
    [m_labCart setTextColor:WHITE_COLOR];
    m_labCart.layer.cornerRadius=LabCartSize/2;
    m_labCart.layer.masksToBounds=YES;
    [m_labCart setTextAlignment:NSTextAlignmentCenter];
    [m_labCart setFont:[UIFont FontOfSize:15]];
    [m_btnCart addSubview:m_labCart];
    [m_btnCart addTarget:self action:@selector(showCartView) forControlEvents:UIControlEventTouchUpInside];

    m_labEmpty=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(m_btnCart.frame)+kDistanceMin, 0, 120, kCart_HEIGHT)];
    [m_labEmpty setText:@"购物车是空的"];
    [m_labEmpty setTextColor:getUIColor(0xcccccc)];
    [m_labEmpty setFont:[UIFont LightFontOfSize:15]];
    [m_footerView addSubview:m_labEmpty];
    [m_labEmpty setHidden:YES];
    
    m_btnOrder=[[UIButton alloc]initWithFrame:CGRectMake(kMainScreen_Width-BtnOrderWidth, 0, BtnOrderWidth, BtnOrderHeight)];
    [m_btnOrder setBackgroundColor:getUIColor(0xff5436)];
    [m_btnOrder.titleLabel setFont:[UIFont LightFontOfSize:17]];
    [m_btnOrder setTitle:@"立即下单" forState:UIControlStateNormal];
    [m_footerView addSubview:m_btnOrder];
    [m_btnOrder addTarget:self action:@selector(confirmOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    m_labTotal=[[UILabel alloc]initWithFrame:CGRectMake(kMainScreen_Width-TotalWidth-kDistance-BtnOrderWidth, 0, TotalWidth, kCart_HEIGHT)];
    [m_labTotal setFont:[UIFont LightFontOfSize:15]];
    [m_labTotal setTextAlignment:NSTextAlignmentRight];
    [m_labTotal setTextColor:getUIColor(0xff5436)];
    [m_footerView addSubview:m_labTotal];
    
}
//获得可点餐日期区间
-(void)loadTimeInterval
{
    OrderGetTimeIntervalRequest *request = [OrderGetTimeIntervalRequest new];
    request.page=[NSString stringWithFormat:@"%d",_currentPage];
    [cgClient doOrderGetTimeInterval:request success:^(CGResponse *data, NSString *url) {
        OrderGetTimeIntervalResponse *response=[[OrderGetTimeIntervalResponse alloc]initWithCGResponse:data];
        m_labelTitle.text=response.name;
        OrderTimeIntervalTable *item=response.list[0];
        [m_labMonth setText:[NSString stringWithFormat:@"%@月",item.month]];
        m_weekView.hasLeft=response.hasLeft.intValue;
        m_weekView.hasRight=response.hasRight.intValue;
        m_weekView.lists=response.list;
        [m_weekView addMainView];
        
        for (OrderTimeIntervalTable *interval in response.list) {
            if ([interval.date isEqualToString:_index.ymd]) {
                _item=interval;
                [self headReloadWith:_item];
            }
        }

        for (NSString *type in _item.list) {
            if ([type isEqualToString:_index.type]) {
                _mealType=type;
            }
        }
       
    }];
}
//刷新按钮类别按钮
-(void)headReloadWith:(OrderTimeIntervalTable *)item
{
    _item=item;
    [m_arrayCart removeAllObjects];
    if (_isShowDetilView) {
        m_detailView.itemTable.num=@"0";
        [m_detailView reloadData];
    }
    [self reloadCart];
    [m_headerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSMutableArray *arrayTypes=[NSMutableArray array];
    for (NSString *string in item.list) {
        [arrayTypes addObject:[_dictData objectForKey:string]];
    }
    m_headerBtns=[NSMutableArray array];
    for (int i=0; i<arrayTypes.count; i++) {
        FoodTypeButton *button=[[FoodTypeButton alloc]initWithFrame:CGRectMake((20+BtnWidth)*i+20, 0, BtnWidth, BtnHeight)];
        [button setTitle:arrayTypes[i]];
        [button setTitleColor:getUIColor(0x333333) forState:UIControlStateNormal];
        button.tag=i;
        if ([arrayTypes[i] isEqualToString:[_dictData objectForKey:_foodType]]) {
            button.selected=YES;
            if ([item.date isEqualToString:_index.ymd]) {
                _mealType=_item.list[i];
            }else{
                _mealType=_item.list[0];
            }
        }
        [button addTarget:self action:@selector(btnTypeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [m_headerView addSubview:button];
        [m_headerBtns addObject:button];
    }
    _leftTag=0;
    
    [self loadMemberOrders];
    [m_tableView2 reloadData];
}

//刷新左边列表
-(void)reloadLeftView
{
    [m_leftView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    m_leftArrays=[NSMutableArray array];
    [m_leftArrays addObject:@"当日\n订单"];
    if (_responseData.listCook.count>0) {
        [m_leftArrays addObject:@"私厨"];
    }
    if (_responseData.listRest.count>0) {
        [m_leftArrays addObject:@"餐厅"];
    }
    m_leftBtns=[NSMutableArray array];
    for (int i=0; i<m_leftArrays.count; i++) {
        FoodTypeButton *button=[[FoodTypeButton alloc]initWithFrame:CGRectMake(0, kLeftWidth*i, kLeftWidth, kLeftWidth)];
        button.isLeft=YES;
        [button setTitle:m_leftArrays[i]];
        [button setTitleColor:getUIColor(0x333333) forState:UIControlStateNormal];
        button.tag=i;
        if (_order||m_leftArrays.count==1) {
            button.selected=(i==0);
        }else{
            button.selected=(i==1);
        }
        [button addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [m_leftView addSubview:button];
        [m_leftBtns addObject:button];
    }
    _leftTag=0;

    if (_order==nil&&m_leftArrays.count>1) {
        _leftTag=1;
        _selectTitle=m_leftArrays[1];
        [self loadMemberDatas];
        [m_scrollView setHidden:YES];
        if (_currentPage>=0) {
            [m_footerView setHidden:NO];
        }
        [m_tableView setHidden:NO];
    }
}
//点击类别按钮
-(void)btnTypeClicked:(FoodTypeButton *)button
{
    for (NSInteger i = 0; i < m_headerBtns.count; i ++) {
        FoodTypeButton *btn=m_headerBtns[i];
        if (i == button.tag) {
            if (!button.selected) {
                [m_arrayCart removeAllObjects];
                [self reloadCart];
            }
            _leftTag=0;
            [btn setSelected:YES];
            _mealType=_item.list[button.tag];
            [self loadMemberOrders];
        }else{
            [btn setSelected:NO];
        }
    }
}
-(void)leftBtnClicked:(FoodTypeButton *)button
{
    for (NSInteger i = 0; i < m_leftBtns.count; i ++) {
        FoodTypeButton *btn=m_leftBtns[i];
        if (button.tag!=_selectLeftTag&&_selectLeftTag>0&&button.tag>0) {
            NSString *title=[NSString stringWithFormat:@"私厨和餐厅不能混合点餐，\n您的购物车已包含「%@」的菜品",m_leftArrays[_selectLeftTag]];
            [self.view showHUDDesc:title];
            return;
        }
        if (i == button.tag) {
            [btn setSelected:YES];
            _leftTag=button.tag;
            _selectTitle=m_leftArrays[button.tag];
            if (button.tag!=0) {
                [self loadMemberDatas];
                [m_scrollView setHidden:YES];
                if (_order==nil) {
                    if (_currentPage>=0) {
                        [m_footerView setHidden:NO];
                    }
                    
                }                
                [m_tableView setHidden:NO];
            }else{
                [self reloadTable2];
            }
        }else{
            [btn setSelected:NO];
        }
    }
}

//订单及私厨
-(void)loadMemberOrders
{
    GetMemberAndOrderRequest *request = [GetMemberAndOrderRequest new];
    request.mealType=_mealType;
    request.date=_item.date;
    [cgClient doGetMemberAndOrder:request success:^(CGResponse *data, NSString *url) {
        _responseData=[[GetMembersAndOrderResponse alloc]initWithCGResponse:data];
        if (_isShowDetilView) {
            m_detailView.responseData=_responseData;
            [m_detailView reloadData];
        }
        _order=_responseData.order;
        [self reloadLeftView];
        if (_leftTag!=0) {
            [self loadMemberDatas];
        }else{
            [self reloadTable2];
        }
    }];
}
//私厨菜品列表
-(void)loadMemberDatas
{
    NSMutableArray *arrayIds=[NSMutableArray array];
    
    if (m_leftBtns.count==2) {
        for (ChefTable *chef in _responseData.listCook) {
            [arrayIds addObject:chef.mid];
        }
        for (ChefTable *chef in _responseData.listRest) {
            [arrayIds addObject:chef.mid];
        }
    }else if(m_leftBtns.count==3){
        if (_leftTag==1) {
            for (ChefTable *chef in _responseData.listCook) {
                [arrayIds addObject:chef.mid];
            }
        }
        if (_leftTag==2) {
            for (ChefTable *chef in _responseData.listRest) {
                [arrayIds addObject:chef.mid];
            }
        }
    }else{
        return;
    }
    
    OrderGetMenuRequest *request = [OrderGetMenuRequest new];
    request.mid=[NSString stringWithFormat:@"%@;",[arrayIds componentsJoinedByString:@";"]];
    request.date=_item.date;
    request.type=_mealType;
    [cgClient doOrderGetMenu:request success:^(CGResponse *data, NSString *url) {
        OrderGetMenuResponse *response=[[OrderGetMenuResponse alloc]initWithCGResponse:data];
        m_chefLists=response.list;
        [m_tableView setHidden:NO];
        [m_tableView reloadData];
    }];

}

//下面购物车
-(void)showCartView
{
    if (_isShow) {
        [m_cartView removeFromSuperview];
        m_btnCart.hidden=NO;
        _isShow=NO;
        return;
    }
    if (m_arrayCart.count==0) {
        return;
    }
    
    if (m_cartView==nil) {
        m_cartView=[[TeamCartView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height-50)];
    }
    m_cartView.responseData=_responseData;
    m_cartView.cartList=[NSMutableArray arrayWithArray:m_arrayCart];
    m_btnCart.hidden=YES;
    [self.view.window addSubview:m_cartView];
    __block __typeof(self)weakSelf = self;
    
    m_cartView.changeBlock = ^(NSString *money,NSArray *array)
    {
        m_arrayCart=[NSMutableArray arrayWithArray:array];
        [m_tableView reloadData];
        [weakSelf reloadTotalWith:money];
        
        for (ChefItemTable *item in m_arrayCart) {
            if ([item.Id isEqualToString:m_detailView.itemTable.Id]) {
                m_detailView.itemTable.num=item.num;
                [m_detailView reloadData];
            }
        }
    };
    [m_cartView reloadCartTable];
    
    m_cartView.removeBlock = ^(NSArray *array)
    {
        m_arrayCart=[NSMutableArray arrayWithArray:array];
        if (m_arrayCart.count==0) {
            m_detailView.itemTable.num=@"0";
            [m_detailView reloadData];
        }
        m_btnCart.hidden=NO;
        _isShow=NO;
        [weakSelf reloadCart];
    };
    
    _isShow=YES;
}
-(void)reloadTotalWith:(NSString *)total
{
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:total];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont LightFontOfSize:15]
                          range:NSMakeRange(0, 1)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:getUIColor(0x666666)
                          range:NSMakeRange(0, 1)];
    m_labTotal.attributedText = AttributedStr;
}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==m_tableView2) {
        return _order.lis.count;
    }
    return m_chefLists.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==m_tableView2) {
        ChefTable *item=_order.lis[section];
        return item.list.count;
    }
    ChefTable *chef=m_chefLists[section];
    return chef.list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==m_tableView2) {
        return kCellHeight;
    }
    return kCellHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==m_tableView2) {
        return kCart_HEIGHT;
    }
    return 70;
}
#pragma mtark tableview delegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==m_tableView2) {
        ChefTable *item=_order.lis[section];
        
        UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kCellHeight)];
        [header.layer addSublayer:getLine(20, kMainScreen_Width, kCellHeight, kCellHeight, getUIColor(0xdddddd))];
        UILabel *labelType=[[UILabel alloc]initWithFrame:CGRectMake(kDistance, kDistanceMin, 20, 20)];
        [labelType setBackgroundColor:getUIColor(0x5ccd00)];
        [labelType setFont:[UIFont LightFontOfSize:13]];
        [labelType setTextColor:WHITE_COLOR];
        labelType.layer.cornerRadius=10.0f;
        labelType.layer.masksToBounds=YES;
        [labelType setTextAlignment:NSTextAlignmentCenter];
        [header addSubview:labelType];
        if (item.category.intValue==1) {
            [labelType setBackgroundColor:getUIColor(0x7ecc1e)];
            [labelType setText:@"私"];
        }
        if (item.category.intValue==2) {
            [labelType setBackgroundColor:getUIColor(0x0099ff)];
            [labelType setText:@"厅"];
        }
        
        UILabel *labName=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(labelType.frame)+kDistanceMin, 0, 150, kCellHeight)];
        [labName setText:item.mname];
        [labName setFont:[UIFont FontOfSize:15]];
        [labName setTextColor:getUIColor(0x666666)];
        [header addSubview:labName];
        
        return header;
    }
    ChefTable *chef=m_chefLists[section];
    
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kCellHeight)];
    CGFloat nameW =getTextSize(chef.mname, kMainScreen_Width,[UIFont FontOfSize:15]).width;
    UILabel *labName=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, nameW, kCellHeight)];
    [labName setText:chef.mname];
    [labName setFont:[UIFont FontOfSize:15]];
    [labName setTextColor:getUIColor(0x333333)];
    [header addSubview:labName];
    
    if (_responseData.disable.intValue !=1) {
        UILabel *labStatus=[[UILabel alloc]init];
        
        NSString *status;

        if (_responseData.timeDisable.intValue!=0) {
            if (_responseData.timeDisable.intValue==2) {
                status=@"已截止";
                [labStatus setBackgroundColor:BORDER_COLOR];
            }else{
                if ([_selectTitle isEqualToString:@"私厨"]) {
                    status=@"已截止";
                    [labStatus setBackgroundColor:BORDER_COLOR];
                }else{
                    if (chef.status.intValue==0) {
                        [labStatus setBackgroundColor:GREEN_COLOR];
                        status=@"可点餐";
                    }else{
                        status=@"订单已接满";
                        [labStatus setBackgroundColor:RED_COLOR];
                    }
                }
            }
        }else{
            if (chef.status.intValue==0) {
                if (_responseData.order.Id!=nil) {
                    status=@"今日已有订单";
                    [labStatus setBackgroundColor:RED_COLOR];
                }else{
                    [labStatus setBackgroundColor:GREEN_COLOR];
                    status=@"可点餐";
                }
            }else{
                status=@"订单已接满";
                [labStatus setBackgroundColor:RED_COLOR];
            }
        }
        
        [labStatus setFont:[UIFont LightFontOfSize:13]];
        CGFloat statusW =getTextSize(status, kMainScreen_Width,[UIFont FontOfSize:13]).width+10;
        [labStatus setFrame:CGRectMake(CGRectGetMaxX(labName.frame)+5, 24/2, statusW, 16)];
        [labStatus setText:status];
        [labStatus setTextColor:WHITE_COLOR];
        labStatus.layer.cornerRadius=16/2;
        labStatus.layer.masksToBounds=YES;
        [labStatus setTextAlignment:NSTextAlignmentCenter];
        [header addSubview:labStatus];
    }
    
    if (section!=0) {
        [header.layer addSublayer:getLine(20, kMainScreen_Width, 0, 0, getUIColor(0xdddddd))];
    }    
    [header.layer addSublayer:getLine(20, kMainScreen_Width, kCellHeight, kCellHeight, getUIColor(0xdddddd))];
    
    
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (tableView==m_tableView2) {
        TeamOrderCell *_cell = (TeamOrderCell *)[tableView dequeueReusableCellWithIdentifier:TeamOrderCellIdentify forIndexPath:indexPath];
        _cell.selectionStyle=UITableViewCellSelectionStyleNone;
        ChefTable *item=_order.lis[indexPath.section];
        [_cell bindWith:item.list[indexPath.row]];
        cell=_cell;
    }else{
        ChefItemCell *_cell = (ChefItemCell *)[tableView dequeueReusableCellWithIdentifier:ChefItemCellIdentify forIndexPath:indexPath];
        _cell.chef=m_chefLists[indexPath.section];
        _cell.responseData=_responseData;
        _cell.leftTilte=_selectTitle;
        _cell.selectionStyle=UITableViewCellSelectionStyleNone;
        ChefTable *chef=m_chefLists[indexPath.section];
        ChefItemTable *item=chef.list[indexPath.row];
        
        if (m_arrayCart.count==0) {
            item.num=@"0";
        }else{
            NSMutableArray *arrayIds=[NSMutableArray array];
            for (ChefItemTable *cart in m_arrayCart) {
                [arrayIds addObject:cart.Id];
                if ([cart.Id isEqualToString:item.Id]) {
                    item.num=cart.num;
                }
            }
            if (![arrayIds containsObject:item.Id]) {
                item.num=@"0";
            }
        }
        _cell.carts=[NSArray arrayWithArray:m_arrayCart];
        [_cell bindWith:item];
        
        _cell.showDetailBlock=^(ChefItemTable *item)
        {
            [self showDetail:item :chef];
        };
        
        __weak __typeof(&*_cell)weakCell =_cell;
        __block __typeof(self)bself = self;
        _cell.plusBlock = ^(ChefItemTable *item,int nCount,BOOL animated)
        {
            if (animated) {
                CGRect parentRectA = [weakCell convertRect:weakCell.btnAdd.frame toView:self.view];
                CGRect parentRectB = [m_btnCart convertRect:m_labCart.frame toView:self.view];
                
               UIImageView *redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LabCartSize, LabCartSize)];
                [redView setBackgroundColor:[UIColor redColor]];
                redView.layer.cornerRadius = LabCartSize/2;

                
                [bself.view addSubview:redView];
                [[ThrowLineTool sharedTool] throwObject:redView from:parentRectA.origin to:parentRectB.origin];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [redView removeFromSuperview];
                });
                item.num=[NSString stringWithFormat:@"%d",nCount];
                
                NSMutableArray *arrayIds=[NSMutableArray array];
                for (ChefItemTable *item in m_arrayCart) {
                    [arrayIds addObject:item.Id];
                }
                if ([arrayIds containsObject:item.Id]) {
                    for (ChefItemTable *cart in m_arrayCart) {
                        if ([cart.Id isEqualToString:item.Id]) {
                            cart.num=[NSString stringWithFormat:@"%d",nCount];
                        }
                    }
                }else{
                    [m_arrayCart addObject:item];
                }
                
            }else{
                if (nCount==0) {
                    for (ChefItemTable *cart in m_arrayCart) {
                        if ([cart.Id isEqualToString:item.Id]) {
                            [m_arrayCart removeObject:cart];
                            break;
                        }
                    }
                    
                }else{
                    item.num=[NSString stringWithFormat:@"%d",nCount];
                    for (ChefItemTable *cart in m_arrayCart) {
                        if ([cart.Id isEqualToString:item.Id]) {
                            cart.num=[NSString stringWithFormat:@"%d",nCount];
                        }
                    }
                }
            }
            [self reloadCart];
        };
        
        cell=_cell;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = kCellHeight;
    if (_leftTag==0) {
        sectionHeaderHeight = CGFLOAT_MIN;
    }
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(void)reloadTable2
{
    NSInteger m=_order.lis.count;
    NSInteger n=0;
    for (ChefTable *chef in _order.lis) {
        n=n+chef.list.count;
    }
    CGFloat height=CGFLOAT_MIN;
    if (m>0 &&n>0) {
        height=kCart_HEIGHT+kCart_HEIGHT*n+kCellHeight*m;
        [m_tableView2 setFrame:CGRectMake(kDistanceMin, kDistanceMin, W(m_scrollView)-2*kDistanceMin, height)];
        [m_scrollView setContentSize:CGSizeMake(W(m_scrollView), H(m_tableView2)+kDistanceMin)];
        [m_tableView2 reloadData];
        [m_emptyView setHidden:YES];
        [m_scrollView setHidden:NO];
        [m_tableView setHidden:YES];
        if (!_isShowDetilView) {
            [m_footerView setHidden:YES];
        }
        
        [m_labTotalMoney setText:[NSString stringWithFormat:@"￥%@",_order.total]];
        [m_labStatus setText:_order.statusStr];
        if (_order.status.intValue==0) {
            [m_labStatus setBackgroundColor:YELLOW_COLOR];
        }else{
            [m_labStatus setBackgroundColor:GREEN_COLOR];
        }
    }else{
        [m_emptyView setHidden:NO];
        [m_scrollView setHidden:YES];
        [m_tableView setHidden:YES];
        if (_currentPage<0) {
            if (!_isShowDetilView) {
                [m_footerView setHidden:YES];
            }
        }else{
            [m_footerView setHidden:NO];
        }
    }
}
-(void)showDetailView
{
    TeamOrderDetailViewController *detail=[[TeamOrderDetailViewController alloc]init];
    detail.orderId=_order.Id;
    [self showNavigationView:detail];
}
-(void)reloadCart
{
    float totalMoney=0;
    int total=0;
    for (ChefItemTable *item in m_arrayCart) {
        totalMoney=totalMoney+item.num.intValue*item.price.floatValue;
        total=total+item.num.intValue;
    }
    [m_labCart setText:[NSString stringWithFormat:@"%d",total]];
    int t=(int)totalMoney;
    NSString *money=[NSString stringWithFormat:@"共￥%.2f",totalMoney];
    if (totalMoney==t) {
        money=[NSString stringWithFormat:@"共￥%d",t];
    }
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont LightFontOfSize:15]
                          range:NSMakeRange(0, 1)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:getUIColor(0x666666)
                          range:NSMakeRange(0, 1)];
    m_labTotal.attributedText = AttributedStr;
    

    if (m_arrayCart.count==0) {
        _selectLeftTag=0;
        [m_labCart setHidden:YES];
        [m_btnCart setImage:[UIImage imageNamed:@"icon-cart-nothing"] forState:UIControlStateNormal];
        [m_btnOrder setEnabled:NO];
        [m_btnOrder setBackgroundColor:getUIColor(0xcccccc)];
        [m_labTotal setHidden:YES];
        [m_labEmpty setHidden:NO];
    }else{
        _selectLeftTag=_leftTag;
        [m_labEmpty setHidden:YES];
        [m_labCart setHidden:NO];
        [m_btnCart setImage:[UIImage imageNamed:@"icon-cart"] forState:UIControlStateNormal];
        [m_btnOrder setEnabled:YES];
        [m_btnOrder setBackgroundColor:getUIColor(0xff5436)];
        [m_labTotal setHidden:NO];
    }
    [m_tableView reloadData];
}
-(void)confirmOrder:(UIButton *)button
{
    if (m_arrayCart.count==0) {
        return;
    }
    NSMutableArray *items=[NSMutableArray array];
    for (ChefItemTable *item in m_arrayCart) {
        NSString *food=[NSString stringWithFormat:@"%@:%@",item.Id,item.num];
        [items addObject:food];
    }
    IsPlaceOrderRequest *request = [IsPlaceOrderRequest new];
    request.items=[items componentsJoinedByString:@";"];
    request.type=_mealType;
    request.date=_item.date;
    [cgClient doIsPlaceOrder:request success:^(CGResponse *data, NSString *url) {
        [self confirmOrder];
    }];
}
-(void)confirmOrder
{
    NSMutableArray *items=[NSMutableArray array];
    for (ChefItemTable *item in m_arrayCart) {
        NSString *food=[NSString stringWithFormat:@"%@:%@",item.Id,item.num];
        [items addObject:food];
    }
    ConfirmOrderResquest *request = [ConfirmOrderResquest new];
    request.items=[items componentsJoinedByString:@";"];
    request.mealType=_mealType;
    request.date=_item.date;
    [cgClient doConfirmOrder:request success:^(CGResponse *data, NSString *url) {
        ConfirmOrderResponse *response=[[ConfirmOrderResponse alloc]initWithCGResponse:data];
        if (_isShow) {
            [m_cartView removeFromSuperview];
            m_btnCart.hidden=NO;
            _isShow=NO;
        }
        ConfirmOrderVC *confirm=[[ConfirmOrderVC alloc]init];
        confirm.mealType=_mealType;
        confirm.date=_item.date;
        confirm.responseData=response;
        confirm.backBlock=^(BOOL back){
            _backConfirm=back;
        };
        [self showNavigationView:confirm];
    }];

}
-(void)showDetail:(ChefItemTable *)item :(ChefTable *)chef
{
    BOOL hide=m_footerView.hidden;
    if (m_detailView==nil) {
        m_detailView = [[TeamFoodDetailView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height-50)];
        m_detailView.cgClient=cgClient;
    }
    m_detailView.chef=chef;
    m_detailView.responseData=_responseData;
    m_detailView.itemTable=item;
    [m_detailView loadDetailData];
    __block __typeof(self)weakSelf = self;
    m_detailView.cartBlock=^(ChefItemTable *item){
        [weakSelf reloadDstasWith:item];
    };
    m_detailView.removeBlock=^(){
        _isShowDetilView=NO;
        [m_footerView setHidden:hide];
    };
    
    CABasicAnimation *animation = nil;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [animation setFromValue:@0.1];
    [animation setToValue:@1.0];
    [animation setDuration:0.25];
    [animation setRemovedOnCompletion:NO];
    [m_detailView.layer addAnimation:animation forKey:@"baseanimation"];
    
    _isShowDetilView=YES;
    [self.view addSubview:m_detailView];
    [self.view bringSubviewToFront:m_footerView];
    [m_footerView setHidden:NO];
}
-(void)reloadDstasWith:(ChefItemTable *)item
{
    if (item.num.intValue==0) {
        for (ChefItemTable *cart in m_arrayCart) {
            if ([cart.Id isEqualToString:item.Id]) {
                [m_arrayCart removeObject:cart];
                break;
            }
        }
    }else{
        NSMutableArray *arrayIds=[NSMutableArray array];
        for (ChefItemTable *item in m_arrayCart) {
            [arrayIds addObject:item.Id];
        }
        if ([arrayIds containsObject:item.Id]) {
            for (ChefItemTable *cart in m_arrayCart) {
                if ([cart.Id isEqualToString:item.Id]) {
                    cart.num=item.num;
                }
            }
        }else{
            [m_arrayCart addObject:item];
        }
    }
    [self reloadCart];
}
@end








