//
//  HomeViewController.m
//  chijidun
//
//  Created by iMac on 16/12/5.
//
//

#import "HomeViewController.h"

#define HomeItemCellIdentify @"HomeItemCell"

#define SearchBtnSize 24
@interface HomeViewController ()
{
    LocationHelper *locationHelper;
    UITableView *m_tableView;
    
    int _currentPage;
    NSMutableArray *m_arrayList;
    NSMutableArray *m_adArray;
    
    UIView *_addressBV;
    UILabel *m_labAddress;
    UIImageView *_downView;
    UILabel *m_labAddress2;
    UIButton *m_btnSearch;
    UIView *m_bannerView;
    
    UIView *m_headerView;
    UIView *m_naviView;
    UIView *m_footer;
    
    NSString *m_city;
    MYTextField *m_searchTF;
    BOOL _isSearchBtn;
    
    BOOL _isChangeLocation;
    SDCycleScrollView *m_scrollView;
}
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    if (_isFirst) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        _isFirst=NO;
    }    
}
-(void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoNotification:) name:@"userInfoNotification" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self tbarBackButton];
    
    _currentPage=1;
    m_arrayList=[NSMutableArray array];
    m_adArray=[NSMutableArray array];
    [self addMainView];
    [self addHeaderView];    
    [self updateLocation];
}
-(void)addMainView
{
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height - kNAV_HEIGHT)];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    //m_tableView.showsVerticalScrollIndicator = NO;
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:m_tableView];
    [m_tableView registerNib:[UINib nibWithNibName:HomeItemCellIdentify bundle:nil] forCellReuseIdentifier:HomeItemCellIdentify];
    
    CGFloat height=kMainScreen_Width*3/5;
    m_bannerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, height)];
    [m_bannerView setBackgroundColor:getUIColor(0xf8f8f8)];
    m_tableView.tableHeaderView=m_bannerView;
    
    m_tableView.mj_header.automaticallyChangeAlpha = YES;
    m_tableView.mj_header = refresh_header;
    @weakify(self)
    self.refreshBlock = ^{
        @strongify(self)
        [self updateLocation];
        [m_tableView.mj_header endRefreshing];
    };
    
    m_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.latt&&self.lngg) {
                _currentPage++;
                [self loadMemberDatas];
            }            
            [m_tableView.mj_footer endRefreshing];
        });
    }];
    
    m_emptyView=[[EmptyView alloc]initWithFrame:CGRectMake(0, height, kMainScreen_Width, kMainScreen_Height - kNAV_HEIGHT-height)];
    [m_emptyView setImage:@"order-empty" Title:@"附近暂无厨房" SubTitle:@""];
    [m_tableView addSubview:m_emptyView];
    [m_emptyView setHidden:YES];
    
    
    m_footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 105)];
    [m_footer setBackgroundColor:  getUIColor(0xf8f8f8)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, kCart_HEIGHT, kMainScreen_Width, 20)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"——· 没有私厨啦 ·——"];
    [label setFont:[UIFont LightFontOfSize:15]];
    [label setTextColor:TEXT_LIGHT];
    [m_footer addSubview:label];
}
-(void)loadAdDatas
{
    IndexGetRequest *indexGetRequest = [IndexGetRequest new];
    [self->apiClient doIndexGet:indexGetRequest success:^(NSMutableDictionary *data, NSString *url) {
        IndexGetResponse *response = [[IndexGetResponse new] fromJSON:data];
        m_adArray = response.data.list;
        if (m_scrollView==nil) {
            m_scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMainScreen_Width, H(m_bannerView)) imageURLStringsGroup:nil];
            m_scrollView.delegate=self;
            m_scrollView.backgroundColor = WHITE_COLOR;
            [m_bannerView addSubview:m_scrollView];
        }
        m_scrollView.showPageControl = YES;
        m_scrollView.autoScrollTimeInterval=4.0;
        m_scrollView.hidesForSinglePage=YES;
        if (m_adArray.count>1) {
            m_scrollView.infiniteLoop=YES;
            m_scrollView.autoScroll=YES;
        }else{
            m_scrollView.infiniteLoop=NO;
            m_scrollView.autoScroll=NO;
        }
        
        NSMutableArray *imagesURLStrings=[NSMutableArray array];
        for (int i=0; i<m_adArray.count; i++) {
            Ad_appTable *item = m_adArray[i];
            [imagesURLStrings addObject:item.banner_img];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            m_scrollView.imageURLStringsGroup = imagesURLStrings;
        });

        
    }];
}
-(void)addHeaderView
{
    m_headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, NAV_HEIGHT)];
    [self.view addSubview:m_headerView];
    
    _addressBV=[[UIView alloc]initWithFrame:CGRectMake(kMainScreen_Width*0.28, 30, kMainScreen_Width*0.44, 25)];
    [_addressBV click:self action:@selector(showChangeLocationVC)];
    [_addressBV setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    _addressBV.layer.cornerRadius=25/2;
    _addressBV.layer.masksToBounds=YES;
    [m_headerView addSubview:_addressBV];
    
    UIImageView *imgView1=[[UIImageView alloc]initWithFrame:CGRectMake(kDistanceMin, 4.5, 13, 16)];
    [imgView1 setImage:[UIImage imageNamed:@"home_location"]];
    [_addressBV addSubview:imgView1];
    
    m_labAddress=[[UILabel alloc]initWithFrame:CGRectMake(26, 0, 115, 25)];
    [m_labAddress setTextColor:WHITE_COLOR];
    [m_labAddress setFont:[UIFont LightFontOfSize:15]];
    [_addressBV addSubview:m_labAddress];
    
    _downView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(m_labAddress.frame)+5, 8.5, 13, 8)];
    [_downView setImage:[UIImage imageNamed:@"home_down"]];
    [_addressBV addSubview:_downView];
    
    if (m_btnSearch==nil) {
        m_btnSearch=[[UIButton alloc]initWithFrame:CGRectMake(kMainScreen_Width-SearchBtnSize-kDistance, 30, SearchBtnSize, SearchBtnSize)];
        [m_btnSearch setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
        [m_btnSearch addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [m_headerView addSubview:m_btnSearch];
    
    m_naviView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, NAV_HEIGHT)];
    [m_naviView setBackgroundColor:WHITE_COLOR];
    [m_naviView setHidden:YES];
    [self.view addSubview:m_naviView];
    
    CGFloat width=70;
    if (iPhone4||iPhone5) {
        width=58;
    }
    
    UIView *addressView=[[UIView alloc]initWithFrame:CGRectMake(0, 26, width+33+S(20), 40)];
    [m_naviView addSubview:addressView];
    [addressView click:self action:@selector(showChangeLocationVC)];
    UIImageView *imgView3=[[UIImageView alloc]initWithFrame:CGRectMake(kDistance, 4.5, 13, 16)];
    [imgView3 setImage:[UIImage imageNamed:@"home_address"]];
    [addressView addSubview:imgView3];
    m_labAddress2=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgView3.frame)+5, 4.5, width, 16)];
    [m_labAddress2 setTextColor:TEXT_MIDDLE];
    [m_labAddress2 setFont:[UIFont LightFontOfSize:14]];
    [addressView addSubview:m_labAddress2];
    
    CGFloat widthS=kMainScreen_Width-CGRectGetWidth(addressView.frame)-kDistance;
    m_searchTF=[[MYTextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(addressView.frame), 26, widthS,27)drawingLeft:@"home_searchBtn"];
    m_searchTF.layer.cornerRadius = 27/2;
    m_searchTF.layer.borderWidth = 1;
    m_searchTF.layer.borderColor = BORDER_COLOR.CGColor;
    [m_searchTF setTextColor:TEXT_MIDDLE];
    [m_searchTF setPlaceholder:@"可搜索私厨名、菜品名" Corlor:DISABLE_COLOR];
    [m_searchTF setFont:[UIFont LightFontOfSize:14]];
    m_searchTF.backgroundColor = WHITE_COLOR;
    m_searchTF.delegate=self;
    [m_naviView addSubview:m_searchTF];
}

//刷新
- (void)updateLocation {
    if (_isChangeLocation) {
        _currentPage=1;
        [self loadMemberDatas];
    }else{
        _currentPage=1;
        [self initLocationHelper];
        [locationHelper run];
        [self loadAdDatas];
    }
}
- (void)initLocationHelper {
    locationHelper = [[LocationHelper alloc] init];
    @weakify(self)
    [locationHelper setSuccess:^(NSMutableDictionary *data, NSString *url) {
        @strongify(self)
        if (parseInt(data[@"status"]) == 0) {
            NSString *locationStr = data[@"result"][@"sematic_description"];
            [self setSearchBarWith:locationStr and:1];
            self.latt = [data[@"result"][@"location"][@"lat"] doubleValue];
            self.lngg = [data[@"result"][@"location"][@"lng"] doubleValue];
            NSString *city=data[@"result"][@"addressComponent"][@"city"];
            if (_currentPage==1) {
                [self loadServiceCitiesWith:city];
            }            
        } else {
            [self setSearchBarWith:@"定位中..." and:2];
        }
    }];
    [locationHelper setFailed:^(NSError *error) {
        @strongify(self)
        [self setSearchBarWith:@"定位失败" and:3];
    }];
}
-(void)setSearchBarWith:(NSString *)text and:(int)status
{
    CGFloat widthT=getTextSize(text, kMainScreen_Width, [UIFont LightFontOfSize:15]).width;
    if (iPhone4||iPhone5) {
        if (widthT>100) {
            widthT=100;
        }
    }else{
        if (widthT>115) {
            widthT=115;
        }
    }
    [m_labAddress setFrame:CGRectMake(26, 0, widthT, 25)];
    CGFloat X=(kMainScreen_Width-(widthT+50))/2;
    [_addressBV setFrame:CGRectMake(X, 30, widthT+50, 25)];
    [_downView setFrame:CGRectMake(CGRectGetMaxX(m_labAddress.frame)+5, 8.5, 13, 8)];
    
    [m_labAddress setText:text];
    [m_labAddress2 setText:text];
    
    if (status==1) {
        [m_emptyView setImage:@"order-empty" Title:@"附近暂无厨房" SubTitle:@""];
        m_tableView.tableFooterView=nil;
    }else if (status==2){
        [m_emptyView setImage:@"home_relocation" Title:@"定位中..." SubTitle:@""];
        [m_emptyView setHidden:NO];
        m_arrayList=[NSMutableArray array];
        m_tableView.tableFooterView=nil;
        [m_tableView reloadData];
    }else if (status==3){
        [m_emptyView setImage:@"home_fail" Title:@"被不明物体挡住gps信号\n无法获取位置"];
        m_emptyView.clickBtnBlock=^(){
            if ([locationHelper isLocationServiceEnable]) {
                [self updateLocation];
            } else {
                [UIApplication openSettings];
            }
        };
        [m_emptyView setBtnWith:@"重新定位"];
        [m_emptyView setHidden:NO];
        m_arrayList=[NSMutableArray array];
        m_tableView.tableFooterView=nil;
        [m_tableView reloadData];
    }
}
-(void)loadServiceCitiesWith:(NSString *)city
{
    ServiceOpenAreaListRequest *request = [ServiceOpenAreaListRequest new];
    [cgClient hideProgress];
    [cgClient disableAfterRequest];
    [cgClient doServiceOpenAreaList:request success:^(CGResponse *_data, NSString *url) {
        ServiceOpenAreaListResponse *response=[[ServiceOpenAreaListResponse alloc]initWithCGResponse:_data];
        NSString *City;
        for (NSDictionary *dict in response.list) {
            if ([dict[@"city"] isEqualToString:city]) {
                City=dict[@"city"];
            }
        }
        if (City.length>0) {
            City=[City stringByReplacingOccurrencesOfString:@"市"withString:@""];
            m_city=City;
            [self loadMemberDatas];
        }
    }];
    
}
- (void)loadMemberDatas
{
    App *app = [App shared];
    CLLocationCoordinate2D lastCoordinate;
    lastCoordinate.latitude = self.latt;
    lastCoordinate.longitude = self.lngg;
    [app setLastCoordinate:lastCoordinate];
    [apiClient hideProgress];
    MemberListsRequest *request = [[MemberListsRequest alloc] init];
    request.pos_lat = [[NSString alloc] initWithFormat:@"%f", self.latt];
    request.pos_lng = [[NSString alloc] initWithFormat:@"%f", self.lngg];
    request.page = [NSString stringWithFormat:@"%d",_currentPage];
    request.perPage = @"10";
    request.city=m_city;
    [self->apiClient doMemberLists:request success:^(NSMutableDictionary *data, NSString *url) {
        MemberListsResponse *response = [[MemberListsResponse alloc] fromJSON:data];
        m_tableView.mj_footer.hidden=(response.data.list.count==0);
        if (response.data.list.count==0) {
            m_tableView.tableFooterView=m_footer;
        }else{
            m_tableView.tableFooterView=nil;
        }
        
        if (_currentPage>1) {
            [m_arrayList addObjectsFromArray:response.data.list];
        }else{
            m_arrayList=response.data.list;
        }
        if (m_arrayList.count==0) {
            [m_emptyView setHidden:NO];
        }else{
            [m_emptyView setHidden:YES];
        }
        [m_tableView reloadData];
    }];
}
#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return m_arrayList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (kMainScreen_Width-20)*3/5+85;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark tableview datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentify = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    if (indexPath.section==0) {
        HomeItemCell *_cell = (HomeItemCell *) [tableView dequeueReusableCellWithIdentifier:HomeItemCellIdentify forIndexPath:indexPath];
        [_cell bindWith:m_arrayList[indexPath.row]];
        _cell.clickBlock=^(MemberTable *member,NSString *itemId){
            [self showChefDetailWith:member :itemId];
        };
        cell= _cell;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showChefDetailWith:m_arrayList[indexPath.row] :@""];
}
-(void)showChefDetailWith:(MemberTable *)member :(NSString *)itemId
{
    ChefDetailVC *detailVC = [[ChefDetailVC alloc]init];
    detailVC.Id = member.Id;
    if (member.statusDistance.intValue==1&&member.statusTomorrow.intValue==1) {
        if (member.status.intValue==1||member.status.intValue==2) {
            detailVC.isTomorrow=YES;
        }
    }
    detailVC.latt=self.latt;
    detailVC.lngg=self.lngg;
    detailVC.selectItemId=itemId;
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:detailVC];
    [self presentViewController:navigationController animated:NO completion:^{
    }];
}
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [self headerImageClicked:index];
}
//滚动图片单击
- (void)headerImageClicked:(NSUInteger)index {
    Ad_appTable *ad = m_adArray[index];
    if (ad.link_url.length>1) {
        FindDetailViewController *detail=[[FindDetailViewController alloc]init];
        detail.isHome=YES;
        detail.adTable=ad;
        [self showNavigationView:detail];
    }
}
-(void)showChangeLocationVC
{
    if ([locationHelper isLocationServiceEnable]) {
        ChangeLocationVC *vc = [[ChangeLocationVC alloc]init];
        vc.selectBlock=^(double lat,double lng,NSString *adddress,BOOL isCurrent){
            self.latt=lat;
            self.lngg=lng;
            [self setSearchBarWith:adddress and:1];
            _currentPage=1;
            [self loadMemberDatas];
            _isChangeLocation=!isCurrent;
        };
        [self showNavigationView:vc];
    } else {
        [UIApplication openSettings];
    }    
}
-(void)showSearchVC
{
    HomeSearchViewController *searchVC = [[HomeSearchViewController alloc]init];
    searchVC.latt=self.latt;
    searchVC.lngg=self.lngg;
    searchVC.city=m_city;
    [self showNavigationView:searchVC];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _isSearchBtn=NO;
    [self showSearchVC];
    return NO;
}
-(void)searchBtnClicked:(id)sender
{
    _isSearchBtn=YES;
    [self showSearchVC];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset<0) {
        [m_naviView setHidden:YES];
        CGFloat alpha = MIN((64+yOffset)/64, 1);
        [m_headerView setAlpha:alpha];
        [m_headerView setHidden:NO];
        [m_tableView setBackgroundColor:WHITE_COLOR];
    }else if (yOffset>=0&&yOffset<64){
        [m_naviView setHidden:YES];
        CGFloat alpha = MIN((64-yOffset)/64, 1);
        m_headerView.alpha = alpha;
        [m_headerView setHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else if (yOffset >= 64){
        [m_naviView setHidden:NO];
        CGFloat alpha = MIN((yOffset-64)/64, 1);
        m_naviView.alpha = alpha;
        [m_headerView setHidden:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        [m_tableView setBackgroundColor:getUIColor(0xf8f8f8)];
    }
    
    CGFloat viewHeight =  scrollView.frame.size.height + scrollView.contentInset.top;
    for (HomeItemCell *cell in [m_tableView visibleCells]) {
        CGFloat y = cell.center.y - scrollView.contentOffset.y;
        CGFloat p = y - viewHeight / 2;
        CGFloat scale = cos(p / viewHeight * 0.8) * 0.95;
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            cell.contentView.transform = CGAffineTransformMakeScale(scale, scale);
            
            cell.contentView.transform=CGAffineTransformIdentity;
        } completion:NULL];        
    }
    
}

-(void)userInfoNotification:(NSNotification*)notification{
    
    NSDictionary *dict = [notification userInfo];
    NSString *url=dict[@"aps"][@"url"];
    NSString *title=dict[@"aps"][@"alert"][@"body"];
    WebHtmlViewController *webVC=[[WebHtmlViewController alloc]initWithTitle:title withUrl:url];
    [self showNavigationView:webVC];
}

@end
