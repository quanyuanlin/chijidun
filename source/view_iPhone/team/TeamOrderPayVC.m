//
//  TeamOrderPayVC.m
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import "TeamOrderPayVC.h"
#define PayCellIdentify @"TeamPaymentCell"
#define AliPay @"aliPay"
#define WXPay @"wxPay"
#define CharPay @"characterPay"
NSString *const TeamOrderPaySuccessNotification = @"TeamOrderPaySuccessNotification";

typedef enum {
    SECTION_ORDER,
    SECTION_PAY,
    SECTION_COUNT
} SECTIONS;
@interface TeamOrderPayVC ()
{
    UITableView *m_tableView;
    
    UIButton *m_btnPay;
    UILabel *m_labMinute;
    UILabel *m_labSecond;
    NSTimer *_timer;
    
    NSInteger _seconds;
    NSString *_payWay;
    CharacterPayView *m_payView;
}
@end

@implementation TeamOrderPayVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"支付订单";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    
    [self loadOrderInfo];
    [self addMainView];
    
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    delegate.delegate_wx = self;
    
    [[NSNotificationCenter defaultCenter]addObserverForName:TeamOrderPaySuccessNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
       // [self goBack];
    }];

}
-(void)goBack
{
    if (_goLastVC) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if (_goFirstVC) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}
-(void)loadOrderInfo
{
    GetOrderInfoRequest *request = [GetOrderInfoRequest new];
    request.Id=_orderId;
    [cgClient doGetOrderInfo:request success:^(CGResponse *data, NSString *url) {
        GetOrderInfoResponse *response=[[GetOrderInfoResponse alloc]initWithCGResponse:data];
        _order=response.order;
        _payWay=[_order.payList[0] objectForKey:@"name"];
        [m_tableView reloadData];
        [self reloadTable];
    }];
}

-(void)addMainView
{
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    [self.view addSubview:m_tableView];
    [m_tableView registerNib:[UINib nibWithNibName:PayCellIdentify bundle:nil] forCellReuseIdentifier:PayCellIdentify];
    [m_tableView setBackgroundColor:getUIColor(0xf8f8f8)];
}
-(void)reloadTable
{
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 100)];
    [header setBackgroundColor:getUIColor(0xff9900)];
    m_tableView.tableHeaderView=header;
    CGFloat width =kMainScreen_Width*0.5;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40, 40, 120, 20)];
    [label setTextColor:WHITE_COLOR];
    [label setFont:[UIFont FontOfSize:15]];
    [label setText:@"支付剩余时间"];
    [header addSubview:label];
    [header.layer addSublayer:getLine(width, width, 25, 75, WHITE_COLOR)];
    
    NSTimeInterval timeInterval=[_order.excessTime doubleValue]/1000;
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    date = [date  dateByAddingTimeInterval: interval];
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComp = [calendar components:unit fromDate:nowDate toDate:date options:0];
    NSInteger m=dateComp.minute;
    NSInteger s=dateComp.second;
    _seconds=m*60+s;
    

    m_labMinute=[[UILabel alloc]initWithFrame:CGRectMake(width+40, 2*kDistance, kCellHeight, kCellHeight)];
    [m_labMinute setTextAlignment:NSTextAlignmentCenter];
    [m_labMinute.layer setBackgroundColor:WHITE_COLOR.CGColor];
    [m_labMinute setTextColor:getUIColor(0xff6600)];
    [m_labMinute setFont:[UIFont BoldFontOfSize:20]];
    m_labMinute.layer.cornerRadius=5.0f;
    [header addSubview:m_labMinute];
    
    m_labSecond=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(m_labMinute.frame)+5, 2*kDistance, kCellHeight, kCellHeight)];
    [m_labSecond.layer setBackgroundColor:WHITE_COLOR.CGColor];
    [m_labSecond setTextAlignment:NSTextAlignmentCenter];
    [m_labSecond setTextColor:getUIColor(0xff6600)];
    [m_labSecond setFont:[UIFont BoldFontOfSize:20]];
    m_labSecond.layer.cornerRadius=5.0f;
    [header addSubview:m_labSecond];
    [self countDownAction];
    
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 85)];
    m_tableView.tableFooterView=footer;
    m_btnPay=[[UIButton alloc]initWithFrame:CGRectMake(35, 45, kMainScreen_Width-70, kCellHeight)];
    m_btnPay.layer.cornerRadius=5.0f;
    [m_btnPay setBackgroundColor:getUIColor(0xff5436)];
    NSString *title=[NSString stringWithFormat:@"确认支付￥%@",_order.userPay];
    [m_btnPay setTitle:title forState:UIControlStateNormal];
    [m_btnPay.titleLabel setFont:[UIFont LightFontOfSize:15]];
    [m_btnPay addTarget:self action:@selector(loadPay) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:m_btnPay];

}
-(void)countDownAction
{
    _seconds--;
    if (_seconds<0) {
        [m_labMinute setText:@"00"];
        [m_labSecond setText:@"00"];
        return;
    }
    NSInteger m=_seconds/60;
    NSInteger s=_seconds%60;
    if (m<10) {
        [m_labMinute setText:[NSString stringWithFormat:@"0%ld",(long)m]];
    }else{
        [m_labMinute setText:[NSString stringWithFormat:@"%ld",(long)m]];
    }
    
    if (s<10) {
        [m_labSecond setText:[NSString stringWithFormat:@"0%ld",(long)s]];
    }else{
        [m_labSecond setText:[NSString stringWithFormat:@"%ld",(long)s]];
    }
    
    if(_seconds==0){
        [_timer invalidate];
        [self goBack];
    }
}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SECTION_COUNT;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==SECTION_PAY) {
        return _order.payList.count+1;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==SECTION_ORDER) {
        return kDistance;
    }
    return CGFLOAT_MIN;
}
#pragma mark tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==SECTION_PAY) {
        if (indexPath.row==0) {
            return kCart_HEIGHT;
        }else{
            return 60.0f;
        }
    }
    return kCart_HEIGHT;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==SECTION_ORDER) {
        [cell.textLabel setText:[NSString stringWithFormat:@"企业团餐-%@",_order.Id]];
        [cell.textLabel setTextColor:getUIColor(0x333333)];
        [cell.textLabel setFont:[UIFont LightFontOfSize:16]];
        
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"￥%@",_order.userPay]];
        [cell.detailTextLabel setTextColor:getUIColor(0xff5436)];
        [cell.detailTextLabel setFont:[UIFont LightFontOfSize:17]];
    }
    if (indexPath.section==SECTION_PAY) {
        if (indexPath.row==0) {
            [cell.textLabel setText:@"选择支付方式"];
            [cell.textLabel setTextColor:getUIColor(0x333333)];
            [cell.textLabel setFont:[UIFont LightFontOfSize:14]];
        }else{
            TeamPaymentCell *_cell = (TeamPaymentCell *)[tableView dequeueReusableCellWithIdentifier:PayCellIdentify forIndexPath:indexPath];
            [_cell bindWith:_order.payList[indexPath.row-1]];
            NSDictionary *dict=_order.payList[indexPath.row-1];
            if ([_payWay isEqualToString:dict[@"name"]]) {
                [_cell.selectView setImage:[UIImage imageNamed:@"icon_check_green"]];
            }else{
                [_cell.selectView setImage:[UIImage imageNamed:@"icon_uncheck"]];
            }
            cell=_cell;
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==SECTION_PAY) {
        if (indexPath.row !=0) {
            NSDictionary *dict=_order.payList[indexPath.row-1];
            _payWay=dict[@"name"];
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            [m_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

-(void)loadPay
{
    TeamOrderPayRequest *request = [TeamOrderPayRequest new];
    request.Id=_orderId;
    request.payment=_payWay;
    [cgClient doTeamOrderPay:request success:^(CGResponse *data, NSString *url) {
        TeamOrderPayResponse *response=[[TeamOrderPayResponse alloc]initWithCGResponse:data];
        if ([response.code intValue]==200) {
            if ([_payWay isEqualToString:AliPay]) {
                [self aliPay:response.data[@"orderString"]];
            }
            if ([_payWay isEqualToString:WXPay]) {
                [self weixinPay:response.data];
            }
            if ([_payWay isEqualToString:CharPay]) {
                [self characterPay:response.data];
            }
        }
    }failure:^(CGResponse *data, NSString *url) {
        if ([data.code intValue]==202){
            TeamOrderDetailViewController *detailVC=[[TeamOrderDetailViewController alloc]init];
            detailVC.orderId=_order.Id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }];
}
-(void)aliPay:(NSString *)sign
{
    //_payWay=@"3";
    NSString *appScheme = @"alipaychi";
    [[AlipaySDK defaultService] payOrder:sign fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@", resultDic);
        BaseResp *br = [[BaseResp alloc] init];
        if ([resultDic[@"resultStatus"] intValue] == 6001) {
            br.errCode = -2;
        }
        else if ([resultDic[@"resultStatus"] intValue] == 9000) {
            br.errCode = 0;
        }
        else {
            br.errCode = -1;
        }
        [self onResp:br];
    }];
}
-(void)weixinPay:(NSDictionary *)response
{
    PayReq *request = [[PayReq alloc] init];
    request.openID = response[@"appid"];
    request.partnerId = response[@"partnerid"];
    request.prepayId = response[@"prepayid"];
    request.nonceStr = response[@"noncestr"];
    request.timeStamp = (UInt32) [response[@"timestamp"] intValue];
    request.package = response[@"package"];
    request.sign = response[@"sign"];
    [WXApi safeSendReq:request];
}
//微信支付
- (void)onResp:(BaseResp *)resp {
    
    NSString *_errorCode=@"1";
    if (resp.errCode == 0) {
        _errorCode=@"0";
    }else{
        _errorCode=@"1";
    }
    TeamOrderPayResultVC *ps = [[TeamOrderPayResultVC alloc] initWithOrder:self.order];
    ps.navigationItem.hidesBackButton=YES;
    ps.isSuccess=!_errorCode.intValue;
    [self.navigationController pushViewController:ps animated:YES];
    
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:_errorCode,@"errCode",_payWay,@"payway", nil];
    NSNotification *notification =[NSNotification notificationWithName:TeamOrderPaySuccessNotification object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
-(void)characterPay:(NSDictionary *)response
{
    if (m_payView==nil) {
        m_payView=[[CharacterPayView alloc]initWithFrame:self.view.window.bounds];
    }
    [self.view.window addSubview:m_payView];
    
    __block __typeof(self)weakSelf = self;
    m_payView.codeBlock=^(NSString *code){
        [weakSelf loadCharacterPayWith:response Code:code];
     };
}
-(void)loadCharacterPayWith:(NSDictionary *)response Code:(NSString *)code
{
    CharacterAppPayRequest *request = [CharacterAppPayRequest new];
    request.preorder_id=response[@"rpf_trade_pay_response"][@"preorder_id"];

    request.user_auth_code=response[@"rpf_trade_pay_response"][@"user_auth_code"];
    request.captcha=code;
    [cgClient doCharacterAppPay:request success:^(CGResponse *data, NSString *url) {
        [self showPayResultViewWith:@"0"];
    }failure:^(CGResponse *data, NSString *error){
        [self showPayResultViewWith:@"1"];
    }];
}
-(void)showPayResultViewWith:(NSString *)errorCode
{
    if (errorCode.intValue==1) {
        CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:@"短信校验码失败，请重试" andMessage:nil];
        view.animationType = AnimationTypeBigToSmall;
        view.titleTextColor = TEXT_DEEP;
        
        __block __typeof(self)weakSelf = self;        
        [view addButtonWithTitle:@"重试" color:TEXT_MIDDLE handler:^(CBWAlertView *alertView){
            [self.view.window addSubview:m_payView];
        }];
        [view addButtonWithTitle:@"重新发送" color:BLUE_COLOR handler:^(CBWAlertView *alertView) {
            [weakSelf loadPay];
        }];
        [view show];
    }else{
        TeamOrderPayResultVC *ps = [[TeamOrderPayResultVC alloc] initWithOrder:self.order];
        ps.navigationItem.hidesBackButton=YES;
        ps.isSuccess=!errorCode.intValue;
        [self.navigationController pushViewController:ps animated:YES];
    }
}
@end
