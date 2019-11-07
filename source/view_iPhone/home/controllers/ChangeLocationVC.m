#import "ChangeLocationVC.h"
#define SearchCellIdentify @"SearchAddressCellHeader"
#define UserAddressCellIdentify @"UserAddressTableViewCell"
#define SearchAddressCell @"SearchAddressTableViewCell"

typedef enum {
    SECTION_Current,
    SECTION_ADDRESS,
    SECTION_NEARBY,
    SECTION_COUNT
} SECTIONS;

@implementation ChangeLocationVC
{
    UITextField *m_searchTF;
    
    UITableView *m_tableView1;
    UITableView *m_tableView2;
    
    EmptyView *m_emptyView;
    NSArray *_addressList;
    NSArray *_nearLists;
    BaiduMapHelper *_mapHelper;
    LocationHelper *locationHelper;
    
    NSString *_currentAddress;
    UIImageView *m_imgView;
    UILabel *m_labAddress;
    
    UIView *m_searchView;
    MYTextField *_searchBar;
    MYTextField *_searchField;
    NSArray *m_searchArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择收货地址";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    
    [self addMainView];
    [self loadData];
}
-(void)addMainView
{
    [self.view setBackgroundColor:WHITE_COLOR];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 50)];
    [titleView setBackgroundColor:NAVI_COLOR];
    
    _searchField=[[MYTextField alloc]initWithFrame:CGRectMake(kDistance, 10, kMainScreen_Width-2*kDistance,30)drawingLeft:@"home_searchBtn"];
    _searchField.layer.cornerRadius = 5.0f;
    _searchField.layer.borderWidth = 1;
    _searchField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _searchField.layer.borderColor = BORDER_COLOR.CGColor;
    [_searchField setTextColor:TEXT_MIDDLE];
    [_searchField setPlaceholder:@"请输入收货地址" Corlor:DISABLE_COLOR];
    [_searchField setFont:[UIFont LightFontOfSize:14]];
    _searchField.backgroundColor = WHITE_COLOR;
    _searchField.delegate=self;
    [titleView addSubview:_searchField];
    [self.view addSubview:titleView];
    
    
    CGFloat height=kMainScreen_Height-NAV_HEIGHT-50;
    m_tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, H(titleView),kMainScreen_Width,height)];
    m_tableView1.delegate = self;
    m_tableView1.dataSource = self;
    [self.view addSubview:m_tableView1];
    [m_tableView1 registerNib:[UINib nibWithNibName:SearchCellIdentify bundle:nil] forCellReuseIdentifier:SearchCellIdentify];
    [m_tableView1 registerNib:[UINib nibWithNibName:UserAddressCellIdentify bundle:nil] forCellReuseIdentifier:UserAddressCellIdentify];
}
- (void)initLocationHelper {
    locationHelper = [[LocationHelper alloc] init];
    [locationHelper run];
    @weakify(self)
    [locationHelper setSuccess:^(NSMutableDictionary *data, NSString *url) {
        @strongify(self)
        if (parseInt(data[@"status"]) == 0) {
            self.latt = [data[@"result"][@"location"][@"lat"] doubleValue];
            self.lngg = [data[@"result"][@"location"][@"lng"] doubleValue];
            
            _currentAddress=data[@"result"][@"sematic_description"];
            [self loadDataLists];
        }
    }];
    [locationHelper setFailed:^(NSError *error) {
    }];
}

-(void)loadData
{
    [self initLocationHelper];
    _mapHelper = [[BaiduMapHelper alloc] init];
    [self fetchSuggestions:@"写字楼"];
}

-(void)loadDataLists
{
    UserAddressListsRequest *request = [UserAddressListsRequest new];
    USER *user = [[App shared] currentUser];
    request.userid=toNSString(user.user_id);
    request.user_lat=[NSString stringWithFormat:@"%f",self.latt];
    request.user_lng=[NSString stringWithFormat:@"%f",self.lngg];
    request.hide=@"1";
    [cgClient hideProgress];
    [cgClient disableAfterRequest];
    [cgClient doUserAddressLists:request success:^(CGResponse *data, NSString *url) {
        UserAddressListsResponse *response=[[UserAddressListsResponse alloc]initWithCGResponse:data];
        _addressList=[NSArray arrayWithArray:response.list];
        [m_tableView1 reloadData];
    }];
    
}
- (void)fetchSuggestions:(NSString *)text {
    [_mapHelper getPOIList:text callback:^(BMKPoiResult *result) {
        _nearLists=[NSArray arrayWithArray:result.poiInfoList];
        [m_tableView1 reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==m_tableView1) {
        return SECTION_COUNT;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==m_tableView1) {
        if (section==SECTION_Current) {
            return 2;
        }
        if (section==SECTION_ADDRESS) {
            return _addressList.count+1;
        }
        if (section==SECTION_NEARBY) {
            return _nearLists.count+1;
        }
    }
    return m_searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentify = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (tableView==m_tableView1) {
        if (indexPath.row==0) {
            if (indexPath.row==0) {
                SearchAddressCellHeader *_cell = (SearchAddressCellHeader *) [tableView dequeueReusableCellWithIdentifier:SearchCellIdentify forIndexPath:indexPath];
                _cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [_cell bindWith:indexPath.section];
                _cell.clickCurrentBlock=^(){
                    [self loadData];
                };
                _cell.clickAddBlock=^(){
                    [self showAddVC];
                };
                cell=_cell;
            }
        }else{
            if (indexPath.section==SECTION_Current) {
                if (m_imgView==nil) {
                    m_imgView=[[UIImageView alloc]initWithFrame:CGRectMake(kDistance, 35/2, 15, 15)];
                    [m_imgView setImage:[UIImage imageNamed:@"address_current"]];
                    
                }
                [cell.contentView addSubview:m_imgView];
                
                if (m_labAddress==nil) {
                    m_labAddress=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(m_imgView.frame)+kDistanceMin, 0, kMainScreen_Width-50, 50)];
                    [m_labAddress setTextColor:RED_COLOR];
                    [m_labAddress setFont:[UIFont LightFontOfSize:17]];
                }
                [cell.contentView addSubview:m_labAddress];
                [m_labAddress setText:_currentAddress];
            }
            if (indexPath.section==SECTION_ADDRESS) {
                UserAddressTableViewCell *_cell = (UserAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:UserAddressCellIdentify forIndexPath:indexPath];
                _cell.selectionStyle=UITableViewCellSelectionStyleNone;
                _cell.btnEdit.hidden=YES;
                _cell.iconView.hidden=YES;
                [_cell bindWith:_addressList[indexPath.row-1]];
                cell=_cell;
            }
            if (indexPath.section==SECTION_NEARBY) {
                [cell.textLabel setFont:[UIFont LightFontOfSize:17]];
                [cell.textLabel setTextColor:TEXT_DEEP];
                BMKPoiInfo *info = _nearLists[indexPath.row-1];
                [cell.textLabel setText:info.name];
            }
        }
    }
    if (tableView==m_tableView2) {
        SearchAddressTableViewCell *_cell = (SearchAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SearchAddressCell forIndexPath:indexPath];
        _cell.selectionStyle=UITableViewCellSelectionStyleNone;
        _cell.table2=YES;
        [_cell.iconView setHidden:YES];
        [_cell bindWith:m_searchArray[indexPath.row]  Index:indexPath.row];
        cell=_cell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==m_tableView1) {
        if (indexPath.section==SECTION_ADDRESS) {
            if (indexPath.row>0) {
                return 75;
            }
        }
        return 50;
    }
    return 75;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==m_tableView1) {
        if (indexPath.section==SECTION_Current) {
            if (indexPath.row==1) {
                if (self.selectBlock) {
                    self.selectBlock(self.latt,self.lngg,_currentAddress,YES);
                }
                [self goBack];
            }
        }
        if (indexPath.section==SECTION_ADDRESS) {
            if (indexPath.row>0) {
                UserAddressTable *address=_addressList[indexPath.row-1];
                NSString *detail=[NSString stringWithFormat:@"%@%@",address.address,address.house_number];
                if (self.selectBlock) {
                    self.selectBlock(address.pos_lat.doubleValue,address.pos_lng.doubleValue,detail,NO);
                }
                [self goBack];
            }
        }
        if (indexPath.section==SECTION_NEARBY) {
            if (indexPath.row>0) {
                BMKPoiInfo *info = _nearLists[indexPath.row-1];
                if (self.selectBlock) {
                    self.selectBlock(info.pt.latitude,info.pt.longitude,info.name,NO);
                }
                [self goBack];
            }
        }
    }
    if (tableView==m_tableView2) {
        BMKPoiInfo *info = m_searchArray[indexPath.row];
        if (self.selectBlock) {
            self.selectBlock(info.pt.latitude,info.pt.longitude,info.name,NO);
        }
        [self hideSearchView];
        [self goBack];
    }
}
-(void)onCancelBtnClick
{
    [self goBack];
}

-(void)showAddVC
{
    USER *user = [[App shared] currentUser];
    if (user.token.length>0) {
        UserAddressAddViewController *addVC=[[UserAddressAddViewController alloc]init];
        addVC.successBlock=^{
            [self loadData];
        };
        [self.navigationController pushViewController:addVC animated:YES];
    }else{
        [self presentVC:[LoginViewController new]];
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField ==_searchField) {
        [self showSearchView];
        return NO;
    }
    return YES;
}

#pragma mark- SearchController
- (void)showSearchView
{
    if (m_searchView==nil) {
        m_searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
        m_searchView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5f];
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, NAV_HEIGHT)];
        [titleView setBackgroundColor:WHITE_COLOR];
        
        _searchBar=[[MYTextField alloc]initWithFrame:CGRectMake(kDistance, 27, kMainScreen_Width-60-kDistance,30)drawingLeft:@"home_searchBtn"];
        _searchBar.layer.cornerRadius = 5.0f;
        _searchBar.layer.borderWidth = 1;
        _searchBar.clearButtonMode=UITextFieldViewModeWhileEditing;
        _searchBar.layer.borderColor = BORDER_COLOR.CGColor;
        [_searchBar setTextColor:TEXT_MIDDLE];
        [_searchBar setPlaceholder:@"请输入收货地址" Corlor:DISABLE_COLOR];
        [_searchBar setFont:[UIFont LightFontOfSize:14]];
        _searchBar.backgroundColor = WHITE_COLOR;
        [_searchBar addTarget:self action:@selector(onEditChanged) forControlEvents:UIControlEventEditingChanged];
        _searchBar.delegate=self;
        _searchBar.returnKeyType=UIReturnKeySearch;
        [titleView addSubview:_searchBar];
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_searchBar.frame)+kDistance, 27, 35, 30)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:RED_COLOR forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [cancelBtn addTarget:self action:@selector(hideSearchView) forControlEvents:UIControlEventTouchUpInside];
        
        [titleView addSubview:cancelBtn];
        [m_searchView addSubview:titleView];
        
        m_tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT,kMainScreen_Width,kMainScreen_Height-NAV_HEIGHT)];
        m_tableView2.delegate = self;
        m_tableView2.dataSource = self;
        [m_searchView addSubview:m_tableView2];
        m_tableView2.bounces=NO;
        [m_tableView2 registerNib:[UINib nibWithNibName:SearchAddressCell bundle:nil] forCellReuseIdentifier:SearchAddressCell];
        
        if (m_emptyView==nil) {
            m_emptyView=[[EmptyView alloc]initWithFrame:m_tableView2.bounds];
            [m_emptyView setImage:@"order-empty" Title:@"找不到?扩大范围试试" SubTitle:nil];
            [m_tableView2 addSubview:m_emptyView];
        }
        [m_emptyView setHidden:YES];
    }
    [m_tableView2 setHidden:YES];
    [self.view.window addSubview:m_searchView];
    [_searchBar becomeFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view setFrame:CGRectMake(0, 14, kMainScreen_Width, kMainScreen_Height)];
    }];
}
-(void)hideSearchView
{
    [m_searchView removeFromSuperview];
    [_searchBar resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view setFrame:CGRectMake(0, NAV_HEIGHT, kMainScreen_Width, kMainScreen_Height)];
    }];
}
-(void)onEditChanged
{
    [m_tableView2 setHidden:NO];
    [_mapHelper getPOIList:_searchBar.text callback:^(BMKPoiResult *result) {
        m_searchArray=[NSArray arrayWithArray:result.poiInfoList];
        if (m_searchArray.count==0) {
            [m_emptyView setHidden:NO];
        }else{
            [m_emptyView setHidden:YES];
        }
        [m_tableView2 reloadData];
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==m_tableView2) {
        [_searchBar resignFirstResponder];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==_searchBar) {
        [self onEditChanged];
        return YES;
    }
    return YES;
}

@end









