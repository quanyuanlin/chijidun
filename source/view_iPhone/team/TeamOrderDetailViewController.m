//
//  TeamOrderDetailViewController.m
//  chijidun
//
//  Created by iMac on 16/9/26.
//
//

#import "TeamOrderDetailViewController.h"
#define FoodCellIdentify @"TeamOrderCell"
#define FoodBigCellIdentify @"TeamOrderBigCell"
#define Img_Size 31

typedef enum {
    SECTION_ORDER,
    SECTION_OTHER,
    SECTION_COUNT
} SECTIONS;
@interface TeamOrderDetailViewController ()
{
    UITableView *m_tableView;
    NSMutableArray *m_arrayItems;
    
    UIView *m_footerView;
    UIButton *m_btnCancel;
    UIButton *m_btnPay;
    
    TeamOrderTable *_order;
    NSTimer *_timer;
    NSInteger _seconds;
}
@end

@implementation TeamOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"订单详情";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    
    [self addMainView];
    [self loadOrderInfo];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
}
-(void)loadOrderInfo
{
    GetOrderInfoRequest *request = [GetOrderInfoRequest new];
    request.Id=_orderId;
    [cgClient doGetOrderInfo:request success:^(CGResponse *data, NSString *url) {
        GetOrderInfoResponse *response=[[GetOrderInfoResponse alloc]initWithCGResponse:data];
        _order=response.order;
        m_arrayItems=[NSMutableArray arrayWithArray:response.items];
        [m_tableView reloadData];
        [self reloadTable];
    }];
}

-(void)addMainView
{
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height-NAV_HEIGHT)];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    [self.view addSubview:m_tableView];
    [m_tableView registerNib:[UINib nibWithNibName:FoodCellIdentify bundle:nil] forCellReuseIdentifier:FoodCellIdentify];
    [m_tableView registerNib:[UINib nibWithNibName:FoodBigCellIdentify bundle:nil] forCellReuseIdentifier:FoodBigCellIdentify];
    [m_tableView setBackgroundColor:getUIColor(0xf8f8f8)];
}
-(void)reloadTable
{
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 100)];
    [header setBackgroundColor:getUIColor(0x5ccd00)];
    m_tableView.tableHeaderView=header;
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake(kDistance, 35, Img_Size, Img_Size)];
    [header addSubview:icon];
    UILabel *labStatus=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame)+2*kDistance, 35, kMainScreen_Width*0.7, 30)];
    [labStatus setFont:[UIFont LightFontOfSize:24]];
    [labStatus setTextColor:WHITE_COLOR];
    [header addSubview:labStatus];
    [labStatus setText:_order.statusStr];
    if (_order.status.intValue==0) {
        [icon setImage:[UIImage imageNamed:@"icon_unpaid"]];
        [header setBackgroundColor:getUIColor(0xff9900)];
    }else{
        [icon setImage:[UIImage imageNamed:@"icon_paid"]];
        [header setBackgroundColor:getUIColor(0x5ccd00)];
    }
    
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 170)];
    [footer setBackgroundColor:WHITE_COLOR];
    [footer.layer addSublayer:getLine(kDistance, kMainScreen_Width, 0, 0, getUIColor(0xdddddd))];
    m_tableView.tableFooterView=footer;
    UIView *back=[[UIView alloc]initWithFrame:CGRectMake(0, 100, kMainScreen_Width, 70)];
    [back setBackgroundColor:getUIColor(0xf8f8f8)];
    [footer addSubview:back];
    
    NSString *orderId=[NSString stringWithFormat:@"订单编号：%@",_order.Id];
    NSString *orderTime=[NSString stringWithFormat:@"用餐时间：%@",_order.mealTime];
    NSString *orderAddr=[NSString stringWithFormat:@"取餐地点：%@",_order.address];
    NSString *orderPay=[NSString stringWithFormat:@"支付方式：%@",_order.payType];
    NSArray *array=@[orderId,orderTime,orderAddr,orderPay];
    
    for (int i=0; i<4; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(kDistance, kDistanceMin+20*i, kMainScreen_Width-2*kDistance, 20)];
        [label setFont:[UIFont LightFontOfSize:13]];
        [label setTextColor:getUIColor(0x666666)];
        [footer addSubview:label];
        [label setText:array[i]];
    }
    
    if (_order.status.intValue==0) {
        CGFloat btnWidth=kMainScreen_Width*0.5;
        m_footerView=[[UIView alloc]initWithFrame:CGRectMake(0, kMainScreen_Height-NAV_HEIGHT-kCart_HEIGHT, kMainScreen_Width, kCart_HEIGHT)];
        [self.view addSubview:m_footerView];
        m_btnCancel=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,btnWidth , kCart_HEIGHT)];
        [m_btnCancel setBackgroundColor:getUIColor(0x888888)];
        [m_btnCancel setTitle:@"取消订单" forState:UIControlStateNormal];
        [m_btnCancel setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [m_btnCancel.titleLabel setFont:[UIFont LightFontOfSize:17]];
        [m_footerView addSubview:m_btnCancel];
        [m_btnCancel addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
        
        m_btnPay=[[UIButton alloc]initWithFrame:CGRectMake(btnWidth, 0,btnWidth , kCart_HEIGHT)];
        [m_btnPay setBackgroundColor:getUIColor(0xff5436)];
        [m_btnPay setTitle:@"确认付款" forState:UIControlStateNormal];
        [m_btnPay setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [m_btnPay.titleLabel setFont:[UIFont LightFontOfSize:17]];
        [m_footerView addSubview:m_btnPay];
        [m_btnPay addTarget:self action:@selector(confirmPay) forControlEvents:UIControlEventTouchUpInside];
        
        
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
        //[m_btnPay setTitle:[NSString stringWithFormat:@"确认付款[%ld:%ld]",(long)m,(long)s] forState:UIControlStateNormal];
        _seconds=m*60+s;
        
        [self countDownAction];
        
    }
    if (_order.status.intValue==1) {
        if (_order.isToday.intValue==1||_order.isHistory.intValue==0) {
            CGFloat left=35;
            m_btnCancel=[[UIButton alloc]initWithFrame:CGRectMake(left, 20,kMainScreen_Width-2*left , kCart_HEIGHT)];
            NSString *title=[NSString stringWithFormat:@"取消订单\n(%@)之前可取消订单",_order.endTime];
            if (_order.isHistory.intValue==0&&_order.isToday.intValue==0) {
                title=@"取消订单";
            }
            NSMutableAttributedString *attriSting=[[NSMutableAttributedString alloc]initWithString:title];
            [attriSting addAttribute:NSFontAttributeName value:[UIFont LightFontOfSize:15] range:NSMakeRange(0, 4)];
            [m_btnCancel setAttributedTitle:attriSting forState:UIControlStateNormal];
            [m_btnCancel.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [m_btnCancel.titleLabel setTextColor:getUIColor(0xff5436)];
            [m_btnCancel.titleLabel setNumberOfLines:2];
            [m_btnCancel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [m_btnCancel setBackgroundColor:WHITE_COLOR];
            [m_btnCancel.titleLabel setFont:[UIFont LightFontOfSize:13]];
            [m_footerView addSubview:m_btnCancel];
            [m_btnCancel addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
            m_btnCancel.layer.borderWidth=1.0f;
            m_btnCancel.layer.borderColor=getUIColor(0xff5436).CGColor;
            m_btnCancel.layer.cornerRadius=5.0f;
            [back addSubview:m_btnCancel];
            if (_order.isToday.intValue==1) {
                NSDate *currentDate =[NSDate date];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH:mm"];
                NSString *currentTime = [dateFormatter stringFromDate:currentDate];
                NSComparisonResult result = [currentTime compare:_order.endTime];
                if (result == NSOrderedDescending) {
                    [m_btnCancel setHidden:YES];
                }else if (result == NSOrderedAscending){
                    [m_btnCancel setHidden:NO];
                }

            }
        }
    }
}
-(void)countDownAction
{
    if (_seconds<0) {
        [m_btnPay setTitle:@"确认付款" forState:UIControlStateNormal];
        return;
    }
    _seconds--;
    NSInteger m=_seconds/60;
    NSInteger s=_seconds%60;
    NSString *minute;
    NSString *seconds;
    if (m<10) {
        minute=[NSString stringWithFormat:@"0%ld",(long)m];
    }else{
        minute=[NSString stringWithFormat:@"%ld",(long)m];
    }
    
    if (s<10) {
        seconds=[NSString stringWithFormat:@"0%ld",(long)s];
    }else{
        seconds=[NSString stringWithFormat:@"%ld",(long)s];
    }
    [m_btnPay setTitle:[NSString stringWithFormat:@"确认付款[%@:%@]",minute,seconds] forState:UIControlStateNormal];
    if(_seconds==0){
        [_timer invalidate];
        m_btnPay.enabled=NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
}

#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SECTION_COUNT;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==SECTION_ORDER) {
        return m_arrayItems.count+2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==SECTION_ORDER) {
        return 20.0f;
    }
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==SECTION_ORDER) {
        UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 20.0f)];
        [footer setBackgroundColor:getUIColor(0xf8f8f8)];
        return footer;
    }
    return nil;
}
#pragma mark tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==SECTION_ORDER) {
        if (indexPath.row==0||indexPath.row==m_arrayItems.count+1) {
            return kCart_HEIGHT;
        }else{
            ChefItemTable *item=m_arrayItems[indexPath.row-1];
            if (item.mname.length>0) {
                CGFloat height=getTextHeight(item.title, kMainScreen_Width-150, [UIFont LightFontOfSize:17]);
                return 70+height;
            }else{
                CGFloat height=getTextHeight(item.title, kMainScreen_Width-140, [UIFont LightFontOfSize:17]);
                
                return height+30;
            }
        }
    }
    if (indexPath.section==SECTION_OTHER) {
        if (indexPath.row==1) {
            return 100;
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
        if (indexPath.row==0) {
            [cell.textLabel setText:@"订单详情"];
            [cell.textLabel setTextColor:getUIColor(0x333333)];
            [cell.textLabel setFont:[UIFont LightFontOfSize:17]];
        }else if(indexPath.row==m_arrayItems.count+1){
            [cell.textLabel setTextColor:getUIColor(0x333333)];
            [cell.textLabel setFont:[UIFont LightFontOfSize:15]];
            
            NSString *money=[NSString stringWithFormat:@"合计￥%@",_order.total];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:getUIColor(0xff5436)
                                  range:NSMakeRange(2, _order.total.length+1)];
            cell.textLabel.attributedText = AttributedStr;
            
            [cell.detailTextLabel setTextColor:getUIColor(0x333333)];
            [cell.detailTextLabel setFont:[UIFont LightFontOfSize:15]];
            
            NSString *paymoney=[NSString stringWithFormat:@"企业付￥%@ 个人付￥%@",_order.companyPay,_order.userPay];
            NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:paymoney];
            [attriStr addAttribute:NSForegroundColorAttributeName
                                  value:getUIColor(0xff5436)
                                  range:NSMakeRange(3, _order.companyPay.length+1)];
            [attriStr addAttribute:NSForegroundColorAttributeName
                             value:getUIColor(0xff5436)
                             range:NSMakeRange(_order.companyPay.length+8, _order.userPay.length+1)];
            cell.detailTextLabel.attributedText = attriStr;
            
        }else{
            ChefItemTable *item=m_arrayItems[indexPath.row-1];
            if (item.mname.length>0) {
                TeamOrderBigCell *_cell = (TeamOrderBigCell *)[tableView dequeueReusableCellWithIdentifier:FoodBigCellIdentify forIndexPath:indexPath];
                _cell.selectionStyle=UITableViewCellSelectionStyleNone;
                _cell.category=_order.category;
                [_cell.labFood setNumberOfLines:0];
                [_cell bindWith:item];
                cell=_cell;
            }else{
                TeamOrderCell *_cell = (TeamOrderCell *)[tableView dequeueReusableCellWithIdentifier:FoodCellIdentify forIndexPath:indexPath];
                _cell.labNameRight.constant=kDistanceMin;
                [_cell.labName setNumberOfLines:0];
                _cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [_cell bindWith:item];
                cell=_cell;
            }
        }
        
    }
    if (indexPath.section==SECTION_OTHER) {
        [cell.textLabel setText:@"其他信息"];
        [cell.textLabel setTextColor:getUIColor(0x333333)];
        [cell.textLabel setFont:[UIFont LightFontOfSize:17]];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)deleteOrder:(UIButton *)button
{
    if(button.selected) return;
    button.selected=YES;    
    DeleteOrderRequest *request = [DeleteOrderRequest new];
    request.orderId=_order.Id;
    [cgClient doDeleteOrder:request success:^(CGResponse *data, NSString *url) {
        [self.view showHUD:@"取消成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            button.selected=NO;
            [self goBack];
        });
    }];
}
-(void)confirmPay
{
    TeamOrderPayVC *payVC=[[TeamOrderPayVC alloc]init];
    payVC.orderId=_orderId;
    payVC.goLastVC=YES;
    [self.navigationController pushViewController:payVC animated:YES];
}
-(void)goBack
{
    if (_goLastVC) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end




