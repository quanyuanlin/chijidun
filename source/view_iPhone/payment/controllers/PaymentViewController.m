#import "PaymentViewController.h"
#import "PayResultViewController.h"
#import "AppDelegate.h"
#import "OrderPayRequest.h"
#import "ApiClient.h"
#import <AlipaySDK/AlipaySDK.h>

#define PayCellIdentify @"TeamPaymentCell"
#define AliPay @"aliPay"
#define WXPay @"wxPay"
NSString *const HUDDismissNotification = @"HUDDismissNotification";

typedef enum {
    SECTION_ORDER,
    SECTION_PAY,
    SECTION_COUNT,
} SECTIONS;
@interface PaymentViewController ()
{
    UITableView *m_tableView;
    
    UIButton *m_btnPay;
    UILabel *m_labMinute;
    UILabel *m_labSecond;
    NSTimer *_timer;
    
    NSArray *_payList;
    NSInteger _seconds;
    NSString *_payWay;
}
@end
@implementation PaymentViewController

- (instancetype)initWithOrder:(ORDER *)anOrder
{
    self = [self init];
    if (self) {
        self.order=[[OrderTable alloc]init];
        self.order.Id=anOrder.rec_id;
    }
    return self;
}
- (instancetype)initWithOrderTable:(OrderTable *)order
{
    self = [self init];
    if (self) {
        self.order=[[OrderTable alloc]init];
        self.order=order;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"支付订单";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    
    [self loadOrderData];
    [self loadPayList];
    [self addMainView];
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    delegate.delegate_wx = self;
    
    [[NSNotificationCenter defaultCenter]addObserverForName:HUDDismissNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
    }];
}
-(void)loadOrderData
{
    OrderGetRequest *request=[OrderGetRequest new];
    request.Id = self.order.Id;
    [apiClient doOrderGet:request success:^(NSMutableDictionary *_data, NSString *url) {
        OrderGetResponse *response=[[OrderGetResponse new]fromJSON:_data];
        _order=response.data;
        [self reloadTable];
        [m_tableView reloadData];
    }];
}
-(void)loadPayList
{
    OrderPayListRequest *request = [OrderPayListRequest new];
    [cgClient hideProgress];
    [cgClient doOrderPayList:request success:^(CGResponse *_data, NSString *url) {
        OrderPayListResponse *_response=[[OrderPayListResponse alloc]initWithCGResponse:_data];
        _payList=[NSArray arrayWithArray:_response.payList];
        NSDictionary *dict=_payList[0];
        _payWay=dict[@"name"];
        [m_tableView reloadData];
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
    _seconds=_order.left_time.intValue;
    
    
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
    NSString *title=[NSString stringWithFormat:@"确认支付￥%@",_order.htotal];
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
        return _payList.count+1;
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
        [cell.textLabel setText:[NSString stringWithFormat:@"个人订单-%@",_order.orderid]];
        [cell.textLabel setTextColor:getUIColor(0x333333)];
        [cell.textLabel setFont:[UIFont LightFontOfSize:16]];
        
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"￥%@",_order.htotal]];
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
            [_cell bindWith:_payList[indexPath.row-1]];
            NSDictionary *dict=_payList[indexPath.row-1];
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
            NSDictionary *dict=_payList[indexPath.row-1];
            _payWay=dict[@"name"];
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            [m_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

-(void)loadPay
{
    progressbar.labelText = @"支付中";
    [progressbar show:YES];
    
    OrderPayRequest *request = [OrderPayRequest new];
    if ([_payWay isEqualToString:AliPay]) {
        request.pays = @"3";
    }else if ([_payWay isEqualToString:WXPay]) {
        request.pays = @"4";
    }
    request.platform = @"ios";
    request.Id = [[NSString alloc] initWithFormat:@"%@", self.order.Id];
    [apiClient doOrderPay:request success:^(NSMutableDictionary *data, NSString *url) {
        OrderPayData *result = [[OrderPayResponse new] fromJSON:data].data;
        if ([result.pays isEqualToString:@"3"]) {
            [self aliPay:result.ali_pay_result.orderString];
        }
        else if ([result.pays isEqualToString:@"4"]) {
            PayReq *request = [[PayReq alloc] init];
            request.openID = result.wx_pay_result.appid;
            request.partnerId = result.wx_pay_result.partnerid;
            request.prepayId = result.wx_pay_result.prepayid;
            request.nonceStr = result.wx_pay_result.noncestr;
            request.timeStamp = (UInt32) [result.wx_pay_result.timestamp intValue];
            request.package = result.wx_pay_result.package;
            request.sign = result.wx_pay_result.sign;
            [WXApi safeSendReq:request];
        }
        [progressbar hide:YES];
    }failure:^(NSMutableDictionary *data, NSString *url) {
        if ([data[@"status"] intValue]==2){
            OrderDetailViewController *detailVC = [[OrderDetailViewController alloc] initWithOrderId:self.order.Id With:_isCheckOut];
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    }];
}
-(void)aliPay:(NSString *)sign
{
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
//微信支付
- (void)onResp:(BaseResp *)resp {
    PayResultViewController *ps = [[PayResultViewController alloc] initWithOrderTable:self.order];
    ps.navigationItem.hidesBackButton=YES;
    ps.isCheckOut=_isCheckOut;
    ps.isSuccess=(resp.errCode==0);
    [self.navigationController pushViewController:ps animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HUDDismissNotification object:nil userInfo:nil];
}
-(void)goBack
{
    if (_isCheckOut) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

@end













