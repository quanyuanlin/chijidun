//
//  UserAddressListViewController.m
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import "UserAddressListViewController.h"
#define UserAddressCellIdentify @"UserAddressTableViewCell"
#define UserAddressNeedCompleteIdentify @"UserAddressCompleteTableViewCell"

#define IMG_WIDTH 120
#define IMG_HEIGHT 150
@interface UserAddressListViewController ()
{
    UITableView *m_tableView;
    
    UIButton *m_addButton;
    LocationHelper *locationHelper;
    
    NSString *_lat;
    NSString *_lng;
    NSMutableArray *m_arrayList;
    
    int _currentPage;
    
    BOOL _isCheckOut;
    UserAddressTable *_selectAddress;
    EmptyView *m_emptyView;
}
@end

@implementation UserAddressListViewController
-(id)initWithAddress:(UserAddressTable *)address
{
    self=[super init];
    if (self) {
        _selectAddress=[[UserAddressTable alloc]init];
        _selectAddress=address;
        _isCheckOut=YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_isCheckOut?@"选择收货地址":@"我的地址";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    [self.navigationController.view.layer addSublayer:getLine(0, kMainScreen_Width, NAV_HEIGHT, NAV_HEIGHT, BORDER_COLOR)];
    
    _currentPage=1;
    m_arrayList=[NSMutableArray array];
    [self addSubviews];
    [self initLocationHelper];
}
- (void)initLocationHelper {
    locationHelper = [[LocationHelper alloc] init];
    [locationHelper run];
    @weakify(self)
    [locationHelper setSuccess:^(NSMutableDictionary *data, NSString *url) {
        @strongify(self)
        if (parseInt(data[@"status"]) == 0) {
            _lat = [NSString stringWithFormat:@"%f",[data[@"result"][@"location"][@"lat"] doubleValue]];
            _lng = [NSString stringWithFormat:@"%f",[data[@"result"][@"location"][@"lng"] doubleValue]];
            [self loadDataLists];
        }
    }];
    [locationHelper setFailed:^(NSError *error) {
    }];
}

-(void)loadDataLists
{
    UserAddressListsRequest *request = [UserAddressListsRequest new];
    request.page=[NSString stringWithFormat:@"%d",_currentPage];
    request.perPage=@"10";
    USER *user = [[App shared] currentUser];
    request.userid=toNSString(user.user_id);
    request.user_lat=_lat;
    request.user_lng=_lng;
    if (_isCheckOut) {
        request.chef_lat=self.member.pos_lat;
        request.chef_lng=self.member.pos_lng;
        request.chef_distance=[NSString stringWithFormat:@"%.0f",_member.min_range.floatValue*1000];
    }
    [cgClient hideProgress];
    [cgClient doUserAddressLists:request success:^(CGResponse *data, NSString *url) {
        UserAddressListsResponse *response=[[UserAddressListsResponse alloc]initWithCGResponse:data];
        if (_currentPage>1) {
            [m_arrayList addObjectsFromArray:response.list];
        }else{
            m_arrayList=[NSMutableArray arrayWithArray:response.list];
        }
        if (m_arrayList.count==0) {
            [m_emptyView setHidden:NO];
            [self.view setBackgroundColor:WHITE_COLOR];
        }else{
            [m_emptyView setHidden:YES];
            [self.view setBackgroundColor:BG_COLOR];
        }
        [m_tableView reloadData];
    }];

}
-(void)addSubviews
{
    [self.view setBackgroundColor:WHITE_COLOR];
    CGFloat height=kMainScreen_Height-2*kCart_HEIGHT-NAV_HEIGHT-5;
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width,height)];
    [m_tableView setBackgroundColor:BG_COLOR];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    [self.view addSubview:m_tableView];
    [m_tableView registerNib:[UINib nibWithNibName:UserAddressCellIdentify bundle:nil] forCellReuseIdentifier:UserAddressCellIdentify];
    [m_tableView registerNib:[UINib nibWithNibName:UserAddressNeedCompleteIdentify bundle:nil] forCellReuseIdentifier:UserAddressNeedCompleteIdentify];
    
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 15)];
    [header setBackgroundColor:BG_COLOR];
    m_tableView.tableHeaderView=header;
    
    @weakify(self)
    m_tableView.mj_header = refresh_header1;
    self.refreshBlock = ^{
        @strongify(self)
        if (_isCheckOut) {
            if (_lat.length==0||_lng.length==0) {
                [m_tableView.mj_header endRefreshing];
                return;
            }
        }
        _currentPage=1;
        [self loadDataLists];
        [m_tableView.mj_header endRefreshing];
    };
    m_tableView.mj_header.automaticallyChangeAlpha = YES;
    m_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _currentPage++;
            [self loadDataLists];
            [m_tableView.mj_footer endRefreshing];
        });
    }];

    if (!m_emptyView) {
        m_emptyView=[[EmptyView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, height)];
        [m_emptyView setEmptyWith:@"address_noaddress" Title:@"您还没有任何收货地址" SubTitle:@"赶紧添加一个吧"];
        [self.view addSubview:m_emptyView];
    }
    [m_emptyView setHidden:YES];

    
    m_addButton=[[UIButton alloc]initWithFrame:CGRectMake(kDistance, kMainScreen_Height-kCart_HEIGHT-kCellHeight-NAV_HEIGHT, kMainScreen_Width-2*kDistance, kCellHeight)];
    [m_addButton setBackgroundColor:YELLOW_COLOR];
    m_addButton.layer.cornerRadius=5.0f;
    m_addButton.layer.masksToBounds=YES;
    [m_addButton setTitle:@"新增地址" forState:UIControlStateNormal];
    [m_addButton.titleLabel setFont:[UIFont LightFontOfSize:17]];
    [m_addButton addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:m_addButton];    
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserAddressTable *address=m_arrayList[indexPath.row];
    NSString *string1=[NSString stringWithFormat:@"%@ %@",address.name,address.tele];
    NSString *string2=[NSString stringWithFormat:@"%@%@",address.address,address.house_number];
    CGFloat height=getTextHeight(string1, kMainScreen_Width-80, [UIFont LightFontOfSize:16])+getTextHeight(string2, kMainScreen_Width-80, [UIFont LightFontOfSize:17]);
    
    if (address.need_complete.intValue==1) {
        return 60+height;
    }
    return 30+height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    UserAddressTable *address=m_arrayList[indexPath.row];
    if (address.need_complete.intValue==1) {
        UserAddressTableViewCell *_cell = (UserAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:UserAddressNeedCompleteIdentify forIndexPath:indexPath];
        _cell.selectionStyle=UITableViewCellSelectionStyleNone;
        _cell.isCheckOut=_isCheckOut;
        [_cell bindWith:m_arrayList[indexPath.row]];
        _cell.editBlock=^{
            _currentPage=1;
            [self loadDataLists];
        };
        cell=_cell;
    }else{
        UserAddressTableViewCell *_cell = (UserAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:UserAddressCellIdentify forIndexPath:indexPath];
        _cell.selectionStyle=UITableViewCellSelectionStyleNone;
        _cell.isCheckOut=_isCheckOut;
        [_cell bindWith:m_arrayList[indexPath.row]];
        if (_isCheckOut) {
            if ([address.Id isEqualToString:_selectAddress.Id]) {
                [_cell.iconView setHidden:NO];
            }else{
                [_cell.iconView setHidden:YES];
            }
        }else{
            [_cell.iconView setHidden:YES];
        }
        _cell.editBlock=^{
            _currentPage=1;
            [self loadDataLists];
        };
        cell=_cell;
    }
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:@"删除地址" andMessage:@"你确定要删除收货地址吗？"];
        view.animationType = AnimationTypeBigToSmall;
        view.titleTextColor = TEXT_DEEP;
        view.messageTextColor = RED_COLOR;
        
        __block __typeof(self)weakSelf = self;
        [view addButtonWithTitle:@"取消" color:BLUE_COLOR handler:^(CBWAlertView *alertView){
        }];
        [view addButtonWithTitle:@"删除" color:BLUE_COLOR handler:^(CBWAlertView *alertView) {
            [weakSelf deleteAddress:m_arrayList[indexPath.row]];
        }];
        [view show];
    }
}
-(void)deleteAddress:(UserAddressTable *)address
{
    UserAddressDeleteRequest *request = [UserAddressDeleteRequest new];
    request.Id=address.Id;
    [cgClient hideProgress];
    [cgClient doUserAddressDelete:request success:^(CGResponse *data, NSString *url) {
        [self.view showHUD:data.result];
         _currentPage=1;
        [self loadDataLists];
        if (_isCheckOut) {
            if ([address.Id isEqualToString:_selectAddress.Id]) {
                _selectAddress=nil;
                if (self.selectBlock) {
                    self.selectBlock(_selectAddress);
                }
            }
        }
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_isCheckOut) {
        UserAddressTable *address=m_arrayList[indexPath.row];
        if (address.selectable.intValue==1&&address.need_complete.intValue==0) {
            _selectAddress=address;
            [m_tableView reloadData];
            if (self.selectBlock) {
                self.selectBlock(m_arrayList[indexPath.row]);
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self goBack];
            });
        }
    }
}
-(void)addAddress:(UIButton *)button
{
    UserAddressAddViewController *addVC=[[UserAddressAddViewController alloc]init];
    addVC.successBlock=^{
        _currentPage=1;
        [self loadDataLists];
    };
    [self.navigationController pushViewController:addVC animated:YES];
}

@end
