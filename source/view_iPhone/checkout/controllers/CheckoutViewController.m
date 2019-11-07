//
//  CheckOutViewController.m
//  chijidun
//
//  Created by iMac on 16/10/31.
//
//

#import "CheckOutViewController.h"

#define FoodCellIdentify @"TeamOrderCell"
#define CheckOutAddressCellIdentify @"CheckOutAddressCell"
#define CheckOutTableHeader @"CheckoutTableViewCellHeader"
#define CheckOutTableCell @"CheckoutTableViewCell"
#define CheckOutTableCellRemark @"RemarkTableViewCell"
#define BtnWidth 125
#define BtnHeight 50
#define LabWidth 200
#define LabHeight 20

typedef enum {
    SECTION_ADDRESS,
    SECTION_COUPON,
    SECTION_ITEMS,
    SECTION_REMARK,
    SECTION_COUNT
} SECTIONS;
@interface CheckOutViewController ()
{
    UITableView *m_tableView;
    BOOL _isTomorrow;
    UILabel *m_labelTotal;
    UIButton *m_btnCheckOut;
    NSString *m_selectTime;
    NSString *m_remark;
    
    LocationHelper *locationHelper;
    
    OrderConfirmOrderResponse *_confirmResponse;
    CartGetByMemberResponse *_response;
    UserAddressTable *_address;
    
    QuanTable *_quan;
    UIButton *m_btnConfirm;
    UILabel *m_labTotal;
    NSString *_days;
    NSString *_times;
    
    PickerTimeView *m_pickView;
    NSArray *_selsetArrays;
    NSString *m_remarkText;
    
    NSString *_currentAddress;
    NSString *_lat;
    NSString *_lng;
}
@end

@implementation CheckOutViewController
-(instancetype)initWithCart:(BOOL)isTomorrow;
{
    self = [self init];
    if (self) {
        _isTomorrow=isTomorrow;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确认订单";
    self.navigationItem.leftBarButtonItem = [self tbarBackButton];
    [self.navigationController.view.layer addSublayer:getLine(0, kMainScreen_Width, NAV_HEIGHT, NAV_HEIGHT, BORDER_COLOR)];
    
    [self addMainView];
    [self initLocationHelper];
    [self loadCartData];
    [self loadConfirmData];
}
-(void)loadCartData
{
    CartGetByMemberRequest *request = [CartGetByMemberRequest new];
    request.mid=_member.Id;
    request.tomorrow=[NSString stringWithFormat:@"%d",_isTomorrow];
    [cgClient hideProgress];
    [cgClient doCartGetByMember:request success:^(CGResponse *_data, NSString *url) {
        _response=[[CartGetByMemberResponse alloc]initWithCGResponse:_data];
        [m_tableView reloadData];
        [self renderTotal];
    }];
    
}
-(void)loadConfirmData
{
    OrderConfirmOrderRequest *request = [OrderConfirmOrderRequest new];
    request.mid=_member.Id;
    request.tomorrow=[NSString stringWithFormat:@"%d",_isTomorrow];
    [cgClient hideProgress];
    [cgClient doOrderConfirmOrder:request success:^(CGResponse *_data, NSString *url) {
        _confirmResponse=[[OrderConfirmOrderResponse alloc]initWithCGResponse:_data];
        [m_pickView reloadDataWith:_confirmResponse.time_list and:_isTomorrow];
        if (_confirmResponse.time_list.count>0) {
            NSString *days=_isTomorrow?@"明天":@"今天";
            [self confirmPickViewWith:days And:_confirmResponse.time_list[0]];
        }
        _quan=[[QuanTable alloc]init];
        _quan=_confirmResponse.quan;
        [self renderTotal];
        [m_tableView reloadData];
    }];

}
- (void)initLocationHelper {
    locationHelper = [[LocationHelper alloc] init];
    [locationHelper run];
    @weakify(self)
    [locationHelper setSuccess:^(NSMutableDictionary *data, NSString *url) {
        @strongify(self)
        if (parseInt(data[@"status"]) == 0) {
            _lat = data[@"result"][@"location"][@"lat"];
            _lng = data[@"result"][@"location"][@"lng"];
            _currentAddress=data[@"result"][@"sematic_description"];
            [self loadAutoAddress];
        }
    }];
    [locationHelper setFailed:^(NSError *error) {
    }];
}
-(void)loadAutoAddress
{
    UserAddressAutoRequest *request = [UserAddressAutoRequest new];
    request.user_lat=_lat;
    request.user_lng=_lng;
    request.chef_lat=_member.pos_lat;
    request.chef_lng=_member.pos_lng;
    request.chef_distance=[NSString stringWithFormat:@"%.0f",_member.min_range.floatValue*1000];
    [cgClient hideProgress];
    [cgClient disableAfterRequest];
    [cgClient doUserAddressAuto:request success:^(CGResponse *_data, NSString *url) {
        UserAddressAutoResponse *response=[[UserAddressAutoResponse alloc]initWithCGResponse:_data];
        _address=[[UserAddressTable alloc]init];
        _address=response.address;
        [m_tableView reloadData];
    }];
}
-(void)addMainView
{
    [self.view setBackgroundColor:WHITE_COLOR];
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height-NAV_HEIGHT-BtnHeight)];
    [m_tableView setBackgroundColor:BG_COLOR];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    [self.view addSubview:m_tableView];
    
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 15)];
    [header setBackgroundColor:BG_COLOR];
    m_tableView.tableHeaderView=header;
    
    [m_tableView registerNib:[UINib nibWithNibName:CheckOutAddressCellIdentify bundle:nil] forCellReuseIdentifier:CheckOutAddressCellIdentify];
    [m_tableView registerNib:[UINib nibWithNibName:CheckOutTableHeader bundle:nil] forCellReuseIdentifier:CheckOutTableHeader];
    [m_tableView registerNib:[UINib nibWithNibName:CheckOutTableCell bundle:nil] forCellReuseIdentifier:CheckOutTableCell];
    [m_tableView registerNib:[UINib nibWithNibName:CheckOutTableCellRemark bundle:nil] forCellReuseIdentifier:CheckOutTableCellRemark];
    [m_tableView registerNib:[UINib nibWithNibName:FoodCellIdentify bundle:nil] forCellReuseIdentifier:FoodCellIdentify];
    
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0,kMainScreen_Height-50-NAV_HEIGHT, kMainScreen_Width, BtnHeight)];
    [footer setBackgroundColor:WHITE_COLOR];
    [self.view addSubview:footer];
    
    m_btnConfirm=[[UIButton alloc]initWithFrame:CGRectMake(kMainScreen_Width-BtnWidth, 0, BtnWidth, BtnHeight)];
    [m_btnConfirm setBackgroundColor:YELLOW_COLOR];
    [m_btnConfirm setTitle:@"确认订单" forState:UIControlStateNormal];
    [m_btnConfirm.titleLabel setFont:[UIFont LightFontOfSize:17]];
    [m_btnConfirm addTarget:self action:@selector(confirmOrder:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:m_btnConfirm];
    
    m_labTotal=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(m_btnConfirm.frame)-kDistance-LabWidth, kDistance, LabWidth, LabHeight)];
    [m_labTotal setFont:[UIFont LightFontOfSize:12]];
    [m_labTotal setTextColor:TEXT_MIDDLE];
    [m_labTotal setTextAlignment:NSTextAlignmentRight];
    [footer addSubview:m_labTotal];
    
    [self initPickerView];
}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SECTION_COUNT;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==SECTION_ADDRESS) {
        return 2;
    }
    if (section==SECTION_ITEMS) {
        return 4+_response.cartlist.count;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 10.0f)];
    [footer setBackgroundColor:BG_COLOR];
    return footer;
}
#pragma mark tableview delegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==SECTION_ADDRESS) {
        if (indexPath.row==0) {
            if (_address) {
                NSString *string1=[NSString stringWithFormat:@"%@ %@",_address.name,_address.tele];
                NSString *string2=[NSString stringWithFormat:@"%@%@",_address.address,_address.house_number];
                CGFloat height=getTextHeight(string1, kMainScreen_Width-107, [UIFont LightFontOfSize:18])+getTextHeight(string2, kMainScreen_Width-107, [UIFont LightFontOfSize:15]);
                return 90+height-38.5;
            }
            return 90;
        }
    }
    if (indexPath.section==SECTION_ITEMS) {
        if (indexPath.row==_response.cartlist.count+2){
            if (_quan.price.floatValue==0) {
                return CGFLOAT_MIN;
            }
        }
    }
    return kTableCellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [cell.textLabel setFont:[UIFont LightFontOfSize:16]];
    [cell.textLabel setTextColor:TEXT_DEEP];
    [cell.detailTextLabel setFont:[UIFont LightFontOfSize:15]];
    [cell.detailTextLabel setTextColor:TEXT_LIGHT];

    if (indexPath.section==SECTION_ADDRESS) {
        if (indexPath.row==0) {
            CheckOutAddressCell *_cell = (CheckOutAddressCell *) [tableView dequeueReusableCellWithIdentifier:CheckOutAddressCellIdentify forIndexPath:indexPath];
            _cell.currentAddress=_currentAddress;
            [_cell bindWith:_address];
            cell= _cell;
        }
        if (indexPath.row==1) {
            [cell.textLabel setFont:[UIFont LightFontOfSize:17]];
            [cell.textLabel setTextColor:TEXT_DEEP];
            [cell.detailTextLabel setFont:[UIFont LightFontOfSize:17]];
            [cell.detailTextLabel setTextColor:TEXT_MIDDLE];
            
            [cell.textLabel setText:@"送达时间"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = m_selectTime;
        }
    }
    if (indexPath.section==SECTION_COUPON) {
        [cell.textLabel setText:@"红包"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (_confirmResponse.quan.price==nil) {
            [cell.detailTextLabel setText:@"无可用红包"];
        }else{
            [cell.detailTextLabel setText:@"选择红包"];
        }
        if (_quan.price.intValue>0) {
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"￥%@",_quan.price]];
        }
    }
    if (indexPath.section==SECTION_ITEMS) {
        [cell.textLabel setFont:[UIFont LightFontOfSize:15]];
        [cell.detailTextLabel setFont:[UIFont LightFontOfSize:15]];
        [cell.textLabel setTextColor:TEXT_DEEP];
        [cell.detailTextLabel setTextColor:TEXT_DEEP];
        cell.accessoryType=UITableViewCellAccessoryNone;
        if (indexPath.row==0) {
            CheckoutTableViewCellHeader *_cell = (CheckoutTableViewCellHeader *) [tableView dequeueReusableCellWithIdentifier:CheckOutTableHeader forIndexPath:indexPath];
            [_cell bindWith:_response.member];
            cell= _cell;
        }else if (indexPath.row==_response.cartlist.count+1){
            [cell.detailTextLabel setFont:[UIFont LightFontOfSize:18]];
            [cell.detailTextLabel setTextColor:RED_COLOR];
            [cell.textLabel setText:@"配送费"];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"￥%@",_expressPrice]];
        }else if (indexPath.row==_response.cartlist.count+2){
            if (_quan.price.floatValue>0) {
                [cell.detailTextLabel setFont:[UIFont LightFontOfSize:18]];
                [cell.detailTextLabel setTextColor:RED_COLOR];
                [cell.textLabel setText:@"红包抵扣"];
                [cell.detailTextLabel setText:[NSString stringWithFormat:@"－￥%@",_quan.price]];
            }
        }else if (indexPath.row==_response.cartlist.count+3){
            [cell.textLabel setFont:[UIFont LightFontOfSize:14]];
            [cell.textLabel setTextColor:TEXT_MIDDLE];
            
            [cell.detailTextLabel setFont:[UIFont LightFontOfSize:16]];
            [cell.detailTextLabel setTextColor:TEXT_DEEP];
            
            float total=0;
            for (ItemTable *item in _response.cartlist) {
                total=total+item.price.floatValue*item.sum.intValue;
            }
            total=total+_expressPrice.intValue;
            NSString *str1=[NSString stringWithFormat:@"总计￥%@",getValue(total)];
            NSString *str2=@"优惠￥0";
            if (_quan.price.floatValue>0) {
                str2=[NSString stringWithFormat:@"优惠￥%@",_quan.price];
            }else{
                str2=@"";
            }

            
            NSString *forward=[NSString stringWithFormat:@"%@ %@",str1,str2];
            NSUInteger length1=str1.length-2;
            NSUInteger length2=str1.length+3;
            NSUInteger length3=str2.length-2;
            NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:forward];
            [AttributedStr1 addAttribute:NSFontAttributeName
                                  value:[UIFont LightFontOfSize:15]
                                  range:NSMakeRange(2, length1)];
            [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                                  value:RED_COLOR
                                  range:NSMakeRange(2, length1)];
            
            if (_quan.price.floatValue>0) {
                [AttributedStr1 addAttribute:NSFontAttributeName
                                       value:[UIFont LightFontOfSize:15]
                                       range:NSMakeRange(length2, length3)];
                [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                                       value:RED_COLOR
                                       range:NSMakeRange(length2, length3)];
            }
            [cell.textLabel setAttributedText:AttributedStr1];
            
            
            float payMoney=total- _quan.price.floatValue;
            if (payMoney<0) {
                payMoney=0;
            }
            NSString *money=[NSString stringWithFormat:@"待支付￥%@",getValue(payMoney)];
            NSUInteger length=money.length-3;
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont FontOfSize:18]
                                  range:NSMakeRange(3, length)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:RED_COLOR
                                  range:NSMakeRange(3, length)];
            [cell.detailTextLabel setAttributedText:AttributedStr];
        }else{
            TeamOrderCell *_cell = (TeamOrderCell *) [tableView dequeueReusableCellWithIdentifier:FoodCellIdentify forIndexPath:indexPath];
            [_cell bindWithCheckOut:_response.cartlist[indexPath.row-1]];
            cell= _cell;
        }
    }
    if (indexPath.section==SECTION_REMARK) {
        [cell.detailTextLabel setFont:[UIFont LightFontOfSize:15]];
        [cell.detailTextLabel setTextColor:getUIColor(0xcccccc)];
        
        [cell.textLabel setText:@"备注"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.detailTextLabel setText:@"口味、偏好等要求"];
        if (m_remark.length>0) {
            [cell.detailTextLabel setTextColor:TEXT_MIDDLE];
            [cell.detailTextLabel setText:m_remark];
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==SECTION_ADDRESS) {
        if (indexPath.row==0) {
            UserAddressListViewController *listVC = [[UserAddressListViewController alloc] initWithAddress:_address];
            listVC.member=[[MemberTable alloc]init];
            listVC.member=_confirmResponse.member;
            listVC.selectBlock=^(UserAddressTable *address){
                _address=[[UserAddressTable alloc]init];
                _address=address;
                [m_tableView reloadData];
            };
            [self showNavigationView:listVC];
        }
        if (indexPath.row==1) {
            if (_confirmResponse.time_list.count==0) {
                [self.view showHUD:@"私厨已打烊，请预定明日"];
                return;
            }
            if (m_pickView) {
                 [self.view.window addSubview:m_pickView];
            }
        }
    }
    if (indexPath.section==SECTION_COUPON) {
        CouponController *couponVC=[[CouponController alloc] initWithCheckOut:_quan];
        couponVC.selectBlock=^(QuanTable *quan){
            _quan=[[QuanTable alloc]init];
            _quan=quan;
            [self renderTotal];
            [m_tableView reloadData];
        };
        [self showNavigationView:couponVC];
    }
    if (indexPath.section == SECTION_REMARK) {
        ReamrkViewController *remarkVC=[[ReamrkViewController alloc]init];
        remarkVC.remark_list=_confirmResponse.remark_list;
        remarkVC.remarkText=m_remarkText;
        remarkVC.selectArrsys=[NSArray arrayWithArray:_selsetArrays];
        remarkVC.selectBlock=^(NSString *remark,NSArray *arrsys){
            _selsetArrays=[NSMutableArray arrayWithArray:arrsys];
            m_remarkText=remark;
            NSMutableArray *array=[NSMutableArray array];
            for (RemarkTable *item in arrsys) {
                [array addObject:item.title];
            }
            NSString *string;
            if (array.count>0&&remark.length>0) {
                string=[NSString stringWithFormat:@"%@,",[array componentsJoinedByString:@","]];
            }else{
                string=[array componentsJoinedByString:@","];
            }
            m_remark=[NSString stringWithFormat:@"%@%@",string,remark];
            [m_tableView reloadData];
        };
        [self.navigationController pushViewController:remarkVC animated:YES];
    }
    
}
#pragma mark picker view delegate

- (void)initPickerView{
    if (!m_pickView) {
        m_pickView = [[PickerTimeView alloc] init];
        m_pickView.p_pickerTimeViewDelegate = self;
        [m_pickView setFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
    }
}
- (void)confirmPickViewWith:(NSString *)days And:(NSString *)times {
    if (days.length>0&&times.length>0) {
        if (_isTomorrow) {
            _days=getTomorrow();
            m_selectTime = [NSString stringWithFormat:@"%@ %@", days, times];
        }else{
            _days=getToday();
            m_selectTime = times;
        }
        _times=times;
        [m_tableView reloadData];
    }
}
#pragma mark remark tableviewcell delegate

- (void)textViewDidEndWith:(NSString *)text {
    m_remark = text;
}

- (void)keyboardWillShow:(NSNotification *)noti {
    float height = 100.0;
    [UIView beginAnimations:@"Curl" context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:CGRectMake(0, -height, kMainScreen_Width, kMainScreen_Height-60)];
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)noti {
    [UIView beginAnimations:@"Curl" context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.view setFrame:CGRectMake(0, 65, kMainScreen_Width, kMainScreen_Height-60)];
    [UIView commitAnimations];
}
#pragma coupon delegate
-(void)didCouponSelected:(QuanTable *)coupon
{
    _quan=coupon;
    [self renderTotal];
    [m_tableView reloadData];
}
-(void)renderTotal
{
    float total=0;
    for (ItemTable *item in _response.cartlist) {
        total=total+item.price.floatValue*item.sum.intValue;
    }
    total=total+ _expressPrice.intValue- _quan.price.floatValue;
    if (total<0) {
        total=0;
    }
    NSString *money=[NSString stringWithFormat:@"待支付￥%@",getValue(total)];
    NSUInteger length=money.length-3;
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont FontOfSize:17]
                          range:NSMakeRange(3, length)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:RED_COLOR
                          range:NSMakeRange(3, length)];
    m_labTotal.attributedText = AttributedStr;
}
-(void)confirmOrder:(UIButton *)button
{
    if (_address==nil) {
        [self.view showHUD:@"地址不能为空"];
        return;
    }
    if (m_selectTime.length==0) {
        [self.view showHUD:@"时间不能为空"];
        return;
    }
    OrderAddRequest *request = [OrderAddRequest new];
    request.pays=@"3";
    request.score=@"0";
    request.address_id=_address.Id;
    request.remark=m_remark;
    request.days=_days;
    request.times=_times;
    request.mid=_response.member.mid;
    request.express=_expressPrice;
    if (_quan) {
        request.quan_id=_quan.Id;
    }
    NSMutableArray *array=[NSMutableArray array];
    for (ItemTable *item in _response.cartlist) {
        [array addObject:item.item_id];
    }
    request.items=[array componentsJoinedByString:@","];
    [cgClient hideProgress];
    [cgClient doOrderAdd:request success:^(CGResponse *_data, NSString *url) {
        OrderAddResponse *response=[[OrderAddResponse alloc]initWithCGResponse:_data];
        
        if (response.order.status.intValue==0) {
            PaymentViewController *ch = [[PaymentViewController alloc] initWithOrderTable:response.order];
            ch.isCheckOut=YES;
            [self.navigationController pushViewController:ch animated:YES];
        }else if (response.order.status.intValue==1){
            PayResultViewController *ps = [[PayResultViewController alloc] initWithOrderTable:response.order];
            ps.isSuccess=YES;
            ps.isCheckOut=YES;
            ps.navigationItem.hidesBackButton=YES;
            [self.navigationController pushViewController:ps animated:YES];
        }
        
    }];
}


@end
