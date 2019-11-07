//
//  UserAddressAddViewController.m
//  chijidun
//
//  Created by iMac on 16/11/17.
//
//

#import "UserAddressAddViewController.h"

#define Left_X 95
#define BtnWidth 60
#define BtnHeight 50
#define kMaxCharacterCount 20
@interface UserAddressAddViewController ()
{
     BOOL _isedit;
    UserAddressTable *_address;
    
    UITableView *m_tableView;
    UIButton *m_confirmBtn;
    
    UIView *m_cellView;
    LocationHelper *locationHelper;

    
    UITextField *m_nameField;
    UITextField *m_teleField;
    UIImageView *m_iconView;
    UITextField *m_addField;
    UITextField *m_detailField;
    
    UIButton *m_manBtn;
    UIButton *m_womanBtn;
    UILabel *m_labelPhone;
}
@end

@implementation UserAddressAddViewController
-(id)initWithAddress:(UserAddressTable *)address Edit:(BOOL)isEdit
{
    self=[super init];
    if (self) {
        _isedit=isEdit;
        _address=[[UserAddressTable alloc]init];
        _address=address;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=_isedit?@"编辑地址":@"新增地址";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    [self.navigationController.view.layer addSublayer:getLine(0, kMainScreen_Width, NAV_HEIGHT, NAV_HEIGHT, BORDER_COLOR)];
    [self.view setBackgroundColor:BG_COLOR];
    
    if (!_isedit) {
        _address=[[UserAddressTable alloc]init];
        [self initLocationHelper];
    }
    [self addSubviews];
}
- (void)initLocationHelper {
    locationHelper = [[LocationHelper alloc] init];
    [locationHelper run];
    @weakify(self)
    [locationHelper setSuccess:^(NSMutableDictionary *data, NSString *url) {
        @strongify(self)
        if (parseInt(data[@"status"]) == 0) {
            [self reloadAddressWith:data];
        }
    }];
    [locationHelper setFailed:^(NSError *error) {
    }];
}
-(void)reloadAddressWith:(NSDictionary *)dict
{
    _address.province=dict[@"result"][@"addressComponent"][@"province"];
    _address.city=dict[@"result"][@"addressComponent"][@"city"];
    _address.area=dict[@"result"][@"addressComponent"][@"district"];
    _address.pos_lat=dict[@"result"][@"location"][@"lat"];
    _address.pos_lng=dict[@"result"][@"location"][@"lng"];
    _address.address=dict[@"result"][@"sematic_description"];
    [m_addField setText:_address.address];
}
-(void)addSubviews
{
    CGFloat height=kMainScreen_Height-2*kCart_HEIGHT-NAV_HEIGHT-5;
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width,height)];
    [m_tableView setBackgroundColor:BG_COLOR];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    //[m_tableView click:self action:@selector(clickBlank:)];
    [self.view addSubview:m_tableView];
    [self addKeyboardNote:5*kCart_HEIGHT];
    
    m_labelPhone=[[UILabel alloc]initWithFrame:CGRectMake(0, 3*kCart_HEIGHT+kDistance, kMainScreen_Width, kCart_HEIGHT)];
    [m_labelPhone setBackgroundColor:getUIColor(0xfff2df)];
    [m_labelPhone setTextColor:ORANGE_COLOR];
    [m_labelPhone setFont:[UIFont LightFontOfSize:24]];
    [m_labelPhone setTextAlignment:NSTextAlignmentCenter];
    USER *user=[[App shared]currentUser];
    [m_labelPhone setText:user.tele];
    [m_labelPhone click:self action:@selector(selectPhone:)];
    [m_tableView addSubview:m_labelPhone];
    [m_labelPhone setHidden:YES];
    
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 15)];
    [header setBackgroundColor:BG_COLOR];
    m_tableView.tableHeaderView=header;
    
    
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 2*kCart_HEIGHT)];
     m_tableView.tableFooterView=footer;
    
    m_confirmBtn=[[UIButton alloc]initWithFrame:CGRectMake(kDistance, 60, kMainScreen_Width-2*kDistance, kCellHeight)];
    [m_confirmBtn setBackgroundColor:YELLOW_COLOR];
    m_confirmBtn.layer.cornerRadius=5.0f;
    m_confirmBtn.layer.masksToBounds=YES;
    [m_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [m_confirmBtn.titleLabel setFont:[UIFont LightFontOfSize:17]];
    [m_confirmBtn addTarget:self action:@selector(confirmClicked:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:m_confirmBtn];
    
    if (_isedit) {
        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 16)];
        [deleteBtn setImage:[UIImage imageNamed:@"address_delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    }
}
-(void)clickBlank:(id)sender
{
    [m_labelPhone setHidden:YES];
    [self textFieldDone];
}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 2*kCart_HEIGHT;
    }
    return kCart_HEIGHT;
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
    [cell.textLabel setFont:[UIFont LightFontOfSize:16]];
    [cell.textLabel setTextColor:TEXT_DEEP];
    if (indexPath.row==0) {
        if (!m_cellView) {
            m_cellView=[[UIView alloc]initWithFrame:cell.contentView.bounds];
            [m_cellView.layer addSublayer:getThinLine(Left_X, kMainScreen_Width, kCart_HEIGHT, kCart_HEIGHT, BORDER_COLOR)];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(kDistance, 0, 80, kCart_HEIGHT)];
            [label setTextColor:TEXT_DEEP];
            [label setFont:[UIFont LightFontOfSize:16]];
            [label setText:@"联系人"];
            [m_cellView addSubview:label];
        }
        [cell.contentView addSubview:m_cellView];
        
        if (!m_nameField) {
            m_nameField=[[UITextField alloc]initWithFrame:CGRectMake(Left_X, 0, kMainScreen_Width-100, kCart_HEIGHT)];
            [m_nameField setPlaceholder:@"请填写收餐人的姓名" Corlor:getUIColor(0xcccccc)];
            m_nameField.returnKeyType=UIReturnKeyDone;
            m_nameField.delegate=self;
            [m_nameField setFont:[UIFont LightFontOfSize:15]];
            [m_nameField setTextColor:TEXT_MIDDLE];
            
            [m_nameField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        }
        [cell.contentView addSubview:m_nameField];
        
        if (!m_manBtn) {
            m_manBtn=[[UIButton alloc]initWithFrame:CGRectMake(Left_X, BtnHeight, BtnWidth, BtnHeight)];
            m_manBtn.adjustsImageWhenHighlighted=NO;
            [m_manBtn setImage:[UIImage imageNamed:@"address_unselect"] forState:UIControlStateNormal];
            [m_manBtn setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateSelected];
            [m_manBtn setTitle:@"先生" forState:UIControlStateNormal];
            [m_manBtn.titleLabel setFont:[UIFont LightFontOfSize:16]];
            [m_manBtn setTitleColor:TEXT_DEEP forState:UIControlStateNormal];
            [m_manBtn addTarget:self action:@selector(sexBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [m_manBtn setImageEdgeInsets:UIEdgeInsetsMake(16, 0, 16, BtnWidth-18)];
            [m_manBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
        }
        [cell.contentView addSubview:m_manBtn];
        
        
        if (!m_womanBtn) {
            m_womanBtn=[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(m_manBtn.frame)+50, BtnHeight, BtnWidth, BtnHeight)];
            m_womanBtn.adjustsImageWhenHighlighted=NO;
            [m_womanBtn setImage:[UIImage imageNamed:@"address_unselect"] forState:UIControlStateNormal];
            [m_womanBtn setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateSelected];
            [m_womanBtn setTitle:@"女士" forState:UIControlStateNormal];
            [m_womanBtn.titleLabel setFont:[UIFont LightFontOfSize:16]];
            [m_womanBtn setTitleColor:TEXT_DEEP forState:UIControlStateNormal];
            [m_womanBtn addTarget:self action:@selector(sexBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [m_womanBtn setImageEdgeInsets:UIEdgeInsetsMake(16, 0, 16, BtnWidth-18)];
            [m_womanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
        }
        [cell.contentView addSubview:m_womanBtn];
        
        if (_address) {
            [m_nameField setText:_address.name];
        }
        if (_address.sex) {
            if ([_address.sex intValue]==1) {
                [m_manBtn setSelected:YES];
            }else if ([_address.sex intValue]==2){
                [m_womanBtn setSelected:YES];
            }
        }else{
            _address.sex=@"1";
            [m_manBtn setSelected:YES];
        }
    }
    if (indexPath.row==1) {
        [cell.textLabel setText:@"联系电话"];
        
        if (!m_teleField) {
            m_teleField=[[UITextField alloc]initWithFrame:CGRectMake(Left_X, 0, kMainScreen_Width-100, kCart_HEIGHT)];
            [m_teleField setPlaceholder:@"请填写收餐人的手机号码" Corlor:getUIColor(0xcccccc)];
            m_teleField.delegate=self;
            m_teleField.keyboardType=UIKeyboardTypeNumberPad;
            [m_teleField setFont:[UIFont LightFontOfSize:15]];
            [m_teleField setTextColor:TEXT_MIDDLE];
        }
        [cell.contentView addSubview:m_teleField];
        
        if (_address) {
            [m_teleField setText:_address.tele];
        }
       
    }
    if (indexPath.row==2) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setText:@"收货地址"];
        if (!m_iconView) {
            m_iconView=[[UIImageView alloc]initWithFrame:CGRectMake(Left_X, 35/2, 12, 15)];
            [m_iconView setImage:[UIImage imageNamed:@"address_gray"]];
        }
        [cell.contentView addSubview:m_iconView];
        
        if (!m_addField) {
            m_addField=[[UITextField alloc]initWithFrame:CGRectMake(Left_X+20, 0, kMainScreen_Width-130, kCart_HEIGHT)];
            m_addField.delegate=self;
            [m_addField setFont:[UIFont LightFontOfSize:15]];
            [m_addField setTextColor:TEXT_MIDDLE];
            m_addField.enabled=NO;
        }
        if (_address) {
            [m_addField setText:_address.address];
        }
        [cell.contentView addSubview:m_addField];
    }
    if (indexPath.row==3) {
        [cell.textLabel setText:@"门牌号码"];
        
        if (!m_detailField) {
            m_detailField=[[UITextField alloc]initWithFrame:CGRectMake(Left_X, 0, kMainScreen_Width-100, kCart_HEIGHT)];
            [m_detailField setPlaceholder:@"请填写收餐具体的门牌号及楼层" Corlor:getUIColor(0xcccccc)];
            m_detailField.delegate=self;
            m_detailField.returnKeyType=UIReturnKeyDone;
            [m_detailField setFont:[UIFont LightFontOfSize:15]];
            [m_detailField setTextColor:TEXT_MIDDLE];
        }
        [cell.contentView addSubview:m_detailField];
        
        if (_address) {
            [m_detailField setText:_address.house_number];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==2) {
        if ([locationHelper isLocationServiceEnable]) {
            [self showChangeLocationVC];
        } else {
            [UIApplication openSettings];
        }
    }
}
-(void)showChangeLocationVC
{
    SelectAddressViewController *vc = [[SelectAddressViewController alloc]init];
    vc.centerPt=CLLocationCoordinate2DMake(_address.pos_lat.doubleValue, _address.pos_lng.doubleValue);
    vc.city=[_address.city stringByReplacingOccurrencesOfString:@"市"withString:@""];;
    [vc setSelectCallback:^(BMKPoiInfo *info) {
        
        BMKGeoCodeSearch *search = [[BMKGeoCodeSearch alloc]init];
        search.delegate = self;
        BMKReverseGeoCodeOption *rever = [[BMKReverseGeoCodeOption alloc]init];
        rever.reverseGeoPoint = info.pt;
        NSLog(@"%d",[search reverseGeoCode:rever]);
        
        _address.pos_lat=[NSString stringWithFormat:@"%f",info.pt.latitude];
        _address.pos_lng=[NSString stringWithFormat:@"%f",info.pt.longitude];
        _address.address=info.name;
        [m_tableView reloadData];
    }];
    [self showNavigationView:vc];
}
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    _address.province=result.addressDetail.province;
    _address.city=result.addressDetail.city;
    _address.area=result.addressDetail.district;
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)confirmClicked:(UIButton *)button
{
    if (m_nameField.text.length==0) {
        [self.view showHUD:@"请填写联系人"];
        return;
    }
    if (m_teleField.text.length==0) {
        [self.view showHUDDesc:@"请输入联系电话,\n方便配送员能够找得到你"];
        return;
    }
    if (![m_teleField.text isMobile]) {
        [self.view showHUD:@"请输入正确的手机号码"];
        return;
    }
    if (m_addField.text.length==0) {
        [self.view showHUD:@"请选择收货地址"];
        return;
    }
    if (_isedit) {
        UserAddressUpdateRequest *request = [UserAddressUpdateRequest new];
        request.Id=_address.Id;
        request.province=_address.province;
        request.address=_address.address;
        request.area=_address.area;
        request.city=_address.city;
        request.pos_lat=_address.pos_lat;
        request.pos_lng=_address.pos_lng;
        request.name=m_nameField.text;
        request.tele=m_teleField.text;
        request.house_number=m_detailField.text;
        request.sex=_address.sex;
        [cgClient hideProgress];
        [cgClient doUserAddressUpdate:request success:^(CGResponse *data, NSString *url) {
            [self.view showHUD:data.result];
            if (self.successBlock) {
                self.successBlock();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self goBack];
            });
        }];
    }else{
        UserAddressAddRequest *request = [UserAddressAddRequest new];
        request.province=_address.province;
        request.address=_address.address;
        request.area=_address.area;
        request.city=_address.city;
        request.pos_lat=_address.pos_lat;
        request.pos_lng=_address.pos_lng;
        request.name=m_nameField.text;
        request.tele=m_teleField.text;
        request.sex=_address.sex;
        request.house_number=m_detailField.text;
        [cgClient hideProgress];
        [cgClient doUserAddressAdd:request success:^(CGResponse *data, NSString *url) {
            [self.view showHUD:data.result];
            if (self.successBlock) {
                self.successBlock();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self goBack];
            });
        }];
    }
    
}
-(void)sexBtnClicked:(UIButton *)button
{
    if (button==m_manBtn) {
        _address.sex=@"1";
        m_manBtn.selected=YES;
        m_womanBtn.selected=NO;
    }
    if (button==m_womanBtn) {
        _address.sex=@"2";
        m_manBtn.selected=NO;
        m_womanBtn.selected=YES;
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==m_teleField) {
        if (textField.text.length==0) {
            if (!_isedit) {
                [m_labelPhone setHidden:NO];
            }
        }
    }else{
        if (!_isedit) {
            [m_labelPhone setHidden:YES];
        }
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==m_teleField) {
        if (range.location==0) {
            if (!_isedit) {
                [m_labelPhone setHidden:YES];
            }
        }
        if (textField.text.length>10) {
            if (string.length == 0) {
                return YES;
            }
            return NO;
        }
    }
    if (textField==m_nameField) {
        if (textField.text.length>19) {
            if (string.length == 0) {
                return YES;
            }
            return NO;
        }
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==m_nameField) {
        _address.name=m_nameField.text;
    }
    if (textField==m_teleField) {
        _address.tele=m_teleField.text;
    }
    if (textField==m_detailField) {
        _address.house_number=m_detailField.text;
    }
}
-(void)selectPhone:(id)sender
{
    _address.tele=m_labelPhone.text;
    [m_teleField setText:_address.tele];
    [m_labelPhone setHidden:YES];
    [m_teleField resignFirstResponder];
}
-(void)rightBarButtonClick:(id)sender
{
    CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:@"删除地址" andMessage:@"你确定要删除收货地址吗？"];
    view.animationType = AnimationTypeBigToSmall;
    view.titleTextColor = TEXT_DEEP;
    view.messageTextColor = RED_COLOR;
    
    __block __typeof(self)weakSelf = self;
    [view addButtonWithTitle:@"取消" color:BLUE_COLOR handler:^(CBWAlertView *alertView){
    }];
    [view addButtonWithTitle:@"删除" color:BLUE_COLOR handler:^(CBWAlertView *alertView) {
        [weakSelf loadDeleteAddress];
    }];
    [view show];
}
-(void)loadDeleteAddress
{
    UserAddressDeleteRequest *request = [UserAddressDeleteRequest new];
    request.Id=_address.Id;
    [cgClient hideProgress];
    [cgClient doUserAddressDelete:request success:^(CGResponse *data, NSString *url) {
        [self.view showHUD:data.result];
        if (self.successBlock) {
            self.successBlock();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self goBack];
        });
    }];
}
-(void)textFieldEditChanged:(UITextField *)textField
{
    if (m_nameField.text.length > kMaxCharacterCount) {
        m_nameField.text = [m_nameField.text substringToIndex:kMaxCharacterCount];
    }
}
@end



