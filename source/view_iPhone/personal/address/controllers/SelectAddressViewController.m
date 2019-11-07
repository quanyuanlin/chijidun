//
//  SelectAddressViewController.m
//  chijidun
//
//  Created by iMac on 16/11/22.
//
//

#import "SelectAddressViewController.h"
#define SearchAddressCell @"SearchAddressTableViewCell"

#define kLeftWidth 70

#define kBtnWidth 35
#define kBtnHeight 30

@interface SelectAddressViewController ()

@end

@implementation SelectAddressViewController
{
    UITableView *_tableView;
    UITableView *_tableView2;
    EmptyView *m_emptyView;
    
    UITextField *searchTF;
    BaiduMapHelper *_mapHelper;
    NSMutableArray *_data;
    selectCallback _selectCallback;
    BOOL _isSearching;
    UIButton *m_backButton;
    
    BMKUserLocation* m_userLocation;
    BMKPointAnnotation *_pointAnnotation;
    
    UIButton *m_cancelBtn;
}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locationService.delegate=self;
    if (_mapView==nil) {
        [self initMapView];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    [_mapView removeFromSuperview];
    [_mapView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _mapView.delegate = nil; // 不用时，置nil
    _locationService.delegate=nil;
    
    _mapView = nil;
    _locationService = nil;
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    if (_locationService) {
        _locationService = nil;
    }
}
-(void)initMapView
{
    if (!self.mapView) {
        BMKMapView *mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width,kMainScreen_Width*3/4)];
        self.mapView=mapView;
        [self.view  addSubview:self.mapView];
        self.mapView.delegate=self;
    }
    
    if (!self.locationService) {
        self.locationService=[[BMKLocationService alloc]init];
        self.locationService.delegate=self;
        [self.locationService startUserLocationService];
    }
    _locationService.desiredAccuracy=kCLLocationAccuracyBest;
    _locationService.distanceFilter=100.0f;
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;
    self.mapView.showsUserLocation = YES;//显示定位图层
    self.mapView.zoomLevel = 19;
    
    UIImageView *centerView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 32)];
    [centerView setImage:[UIImage imageNamed:@"address_annotation"]];
    centerView.center=CGPointMake(kMainScreen_Width/2, kMainScreen_Width*3/8);
    [self.view addSubview:centerView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMapView];
    [self setMainView];
}
-(void)setMainView
{
    self.view.backgroundColor = BG_COLOR;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 30)];
    
    m_backButton=[[UIButton alloc]initWithFrame:CGRectMake(5, 0, 50, 30)];
    m_backButton.adjustsImageWhenHighlighted=NO;
    [m_backButton setImage:[UIImage imageNamed:@"icon-back-left"] forState:UIControlStateNormal];
    [m_backButton setTitle:_city forState:UIControlStateNormal];
    [m_backButton.titleLabel setFont:[UIFont LightFontOfSize:15]];
    [m_backButton setTitleColor:TEXT_MIDDLE forState:UIControlStateNormal];
    [m_backButton addTarget:self action:@selector(onCancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [m_backButton setImageEdgeInsets:UIEdgeInsetsMake(7, 0, 7, 50-16)];
    [m_backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -16, 0, 0)];
    [titleView addSubview:m_backButton];
    
    searchTF=[[MYTextField alloc]initWithFrame:CGRectMake(kLeftWidth, 0, (CGFloat) (kMainScreen_Width-85), 30) drawingLeft:@"changeLocation"];
    searchTF.layer.cornerRadius = 6;
    searchTF.layer.borderWidth = 1;
    searchTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    searchTF.layer.borderColor = BORDER_COLOR.CGColor;
    [searchTF setTextColor:TEXT_MIDDLE];
    [searchTF setPlaceholder:@"查找小区/大厦等" Corlor:DISABLE_COLOR];
    [searchTF setFont:[UIFont LightFontOfSize:15]];
    searchTF.backgroundColor = getUIColor(0xffffff);
    searchTF.delegate=self;
    searchTF.returnKeyType=UIReturnKeySearch;
    [searchTF addTarget:self action:@selector(onEditChanged) forControlEvents:UIControlEventEditingChanged];
    [titleView addSubview:searchTF];
    
    m_cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(searchTF.frame)+kDistanceMin, 0, kBtnWidth, kBtnHeight)];
    [m_cancelBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [m_cancelBtn setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [m_cancelBtn.titleLabel setFont:[UIFont LightFontOfSize:15]];
    [m_cancelBtn addTarget:self action:@selector(onEditChanged) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:m_cancelBtn];
    [m_cancelBtn setHidden:YES];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(-10, titleView.frame.size.height + 6, kMainScreen_Width+5, 1)];
    lineView.backgroundColor = BORDER_COLOR;
    [titleView addSubview:lineView];
    self.navigationItem.titleView = titleView;
    
    CGFloat height=kMainScreen_Width*3/4;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, height,kMainScreen_Width,kMainScreen_Height-height-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces=NO;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:SearchAddressCell bundle:nil] forCellReuseIdentifier:SearchAddressCell];
    
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kMainScreen_Width,kMainScreen_Height-NAV_HEIGHT)];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.bounces=NO;
    [self.view addSubview:_tableView2];
    [_tableView2 registerNib:[UINib nibWithNibName:SearchAddressCell bundle:nil] forCellReuseIdentifier:SearchAddressCell];
    [_tableView2 setHidden:YES];
    if (m_emptyView==nil) {
        m_emptyView=[[EmptyView alloc]initWithFrame:_tableView2.bounds];
        [m_emptyView setImage:@"order-empty" Title:@"找不到?扩大范围试试" SubTitle:nil];
        [_tableView2 addSubview:m_emptyView];
    }
    [m_emptyView setHidden:YES];
    
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 180)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, kMainScreen_Width, 20)];
    [label setFont:[UIFont LightFontOfSize:15]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:TEXT_LIGHT];
    [label setText:@"找不到？搜索试试"];
    [footer addSubview:label];
    _tableView.tableFooterView=footer;
    
    _mapHelper = [[BaiduMapHelper alloc] init];
}
#pragma mark -------BMKLocationServiceDelegate

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    self.mapView.showsUserLocation = YES;
    [self.mapView updateLocationData:userLocation];
    self.mapView.zoomLevel =19;
    m_userLocation=userLocation;
    
    [self.mapView setCenterCoordinate:_centerPt];
    [self geoCodeSearchWith:_centerPt];
}
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CGPoint Point = self.mapView.center;
    CLLocationCoordinate2D pointCoordinate =
    [self.mapView convertPoint:Point toCoordinateFromView:self.mapView];
    [self geoCodeSearchWith:pointCoordinate];
}
-(void)geoCodeSearchWith:(CLLocationCoordinate2D)pt
{
    BMKGeoCodeSearch *search = [[BMKGeoCodeSearch alloc]init];
    search.delegate = self;
    BMKReverseGeoCodeOption *rever = [[BMKReverseGeoCodeOption alloc]init];
    rever.reverseGeoPoint = pt;
    NSLog(@"%d",[search reverseGeoCode:rever]);
}
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    _data=[NSMutableArray arrayWithArray:result.poiList];
    [_tableView reloadData];
}

- (void)setSelectCallback:(selectCallback)callback {
    _selectCallback = callback;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self onEditChanged];
    [searchTF resignFirstResponder];
    return YES;
}
- (void)onEditChanged {
    if (searchTF.text.length>0) {
        _isSearching=YES;
        [searchTF setFrame:CGRectMake(kLeftWidth, 0, (CGFloat) (kMainScreen_Width-kLeftWidth-60), kBtnHeight)];
        [m_cancelBtn setFrame:CGRectMake(CGRectGetMaxX(searchTF.frame)+kDistanceMin, 0, kBtnWidth, kBtnHeight)];
        [m_cancelBtn setHidden:NO];
    }else{
        _isSearching=NO;
        [searchTF setFrame:CGRectMake(kLeftWidth, 0, (CGFloat) (kMainScreen_Width-kLeftWidth-kDistance), kBtnHeight)];
        [m_cancelBtn setFrame:CGRectMake(CGRectGetMaxX(searchTF.frame)+kDistanceMin, 0, kBtnWidth, kBtnHeight)];
        [m_cancelBtn setHidden:YES];
    }
    if (searchTF.text.length == 0)return;
    [self fetchSuggestions:searchTF.text];
}

- (void)fetchSuggestions:(NSString *)text {
    [_mapHelper getPOIList:text callback:^(BMKPoiResult *result) {
        _data=[NSMutableArray arrayWithArray:result.poiInfoList];
        if (_isSearching) {
            [_tableView setHidden:YES];
            [_tableView2 setHidden:NO];
            if (_data.count==0) {
                [m_emptyView setHidden:NO];
            }else{
                [m_emptyView setHidden:YES];
            }
        }else{
            [_tableView setHidden:NO];
            [_tableView2 setHidden:YES];
        }
        [_tableView reloadData];
        [_tableView2 reloadData];
    }];
}
- (void)onCancelBtnClick
{
    if (_selectCallback) {
        if (_data.count>0) {
            _selectCallback(_data[0]);
            [self goBack];
        }        
    }
    [self goBack];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (tableView==_tableView) {
        SearchAddressTableViewCell *_cell = (SearchAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SearchAddressCell forIndexPath:indexPath];
        _cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [_cell bindWith:_data[indexPath.row]  Index:indexPath.row];
        cell=_cell;
    }else{
        SearchAddressTableViewCell *_cell = (SearchAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SearchAddressCell forIndexPath:indexPath];
        _cell.selectionStyle=UITableViewCellSelectionStyleNone;
        _cell.table2=YES;
        [_cell.iconView setHidden:YES];
        [_cell bindWith:_data[indexPath.row]  Index:indexPath.row];
        cell=_cell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectCallback != nil) {
        _selectCallback(_data[(NSUInteger) indexPath.row]);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [searchTF resignFirstResponder];
}



@end
