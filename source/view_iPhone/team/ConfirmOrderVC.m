//
//  ConfirmOrderVC.m
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import "ConfirmOrderVC.h"
#define OrderPayCellIdentify @"ConfirmOrderPayCell"
#define FoodCellIdentify @"TeamOrderCell"
#define FoodBigCellIdentify @"TeamOrderBigCell"

#define Lab_Width 150
#define Btn_Width 120
#define Btn_height 50
typedef enum {
    SECTION_ADDRESS,
    SECTION_FOOD,
    SECTION_PAY,
    SECTION_COUNT
} SECTIONS;
@interface ConfirmOrderVC ()
{
    UITableView *m_tableView;
    
    UILabel *m_labStatus;
    UILabel *m_labAddress;
    
    UIButton *m_btnConfirm;
    UILabel *m_labTotal;
    UILabel *m_labSub;
    AddressView *m_addressView;
    BOOL _showAddressView;
    TeamAddressTable *_address;
}
@end

@implementation ConfirmOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确认订单";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    
    
    for (TeamAddressTable *add in _responseData.address) {
        if (add.isLast.intValue==1) {
            _address=add;
        }
    }
    
    [self addMainView];
}
-(void)addMainView
{
     [self.view setBackgroundColor:WHITE_COLOR];
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height-NAV_HEIGHT-kCart_HEIGHT)];
    [m_tableView setBackgroundColor:getUIColor(0xf8f8f8)];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    [self.view addSubview:m_tableView];
    [m_tableView registerNib:[UINib nibWithNibName:OrderPayCellIdentify bundle:nil] forCellReuseIdentifier:OrderPayCellIdentify];
    [m_tableView registerNib:[UINib nibWithNibName:FoodCellIdentify bundle:nil] forCellReuseIdentifier:FoodCellIdentify];
    [m_tableView registerNib:[UINib nibWithNibName:FoodBigCellIdentify bundle:nil] forCellReuseIdentifier:FoodBigCellIdentify];
    
    UIView *header=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 30)];
    [header setBackgroundColor:getUIColor(0xff5436)];
    m_tableView.tableHeaderView=header;
    m_labStatus=[[UILabel alloc]initWithFrame:CGRectMake(kDistance, 0, kMainScreen_Width*0.8, 30)];
    [m_labStatus setFont:[UIFont LightFontOfSize:14]];
    [m_labStatus setTextColor:WHITE_COLOR];
    [header addSubview:m_labStatus];
    if (_responseData.payType.intValue==0) {
        [m_labStatus setText:@"企业支付订单"];
    }else if (_responseData.payType.intValue==1){
        [m_labStatus setText:@"个人支付订单"];
    }else if (_responseData.payType.intValue==2){
        [m_labStatus setText:@"企业支付订单，超出部分需要个人支付"];
    }
    
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0,kMainScreen_Height-kCart_HEIGHT-NAV_HEIGHT, kMainScreen_Width, kCart_HEIGHT)];
    [footer.layer addSublayer:getLine(0, kMainScreen_Width, 0, 0, BORDER_COLOR)];
    [footer setBackgroundColor:WHITE_COLOR];
    [self.view addSubview:footer];
    
    m_btnConfirm=[[UIButton alloc]initWithFrame:CGRectMake(kMainScreen_Width-Btn_Width, 0, Btn_Width, Btn_height)];
    [m_btnConfirm setBackgroundColor:getUIColor(0xff5436)];
    [m_btnConfirm setTitle:@"确认订单" forState:UIControlStateNormal];
    [m_btnConfirm.titleLabel setFont:[UIFont LightFontOfSize:17]];
    [m_btnConfirm addTarget:self action:@selector(confirmOrder:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:m_btnConfirm];
    
    m_labTotal=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(m_btnConfirm.frame)-kDistance-Lab_Width, 0, Lab_Width, kCart_HEIGHT)];
    [m_labTotal setFont:[UIFont FontOfSize:17]];
    [m_labTotal setTextColor:getUIColor(0xff5436)];
    [m_labTotal setTextAlignment:NSTextAlignmentRight];
    
    NSString *money=[NSString stringWithFormat:@"待支付￥%@",_responseData.userPay];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont LightFontOfSize:12]
                          range:NSMakeRange(0, 3)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:getUIColor(0x666666)
                          range:NSMakeRange(0, 3)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont LightFontOfSize:14]
                          range:NSMakeRange(3, 1)];
    m_labTotal.attributedText = AttributedStr;
    
    [footer addSubview:m_labTotal];
}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SECTION_COUNT;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==SECTION_FOOD) {
        return _responseData.list.count+1;
    }
    if (section==SECTION_PAY) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==SECTION_ADDRESS) {
        return kDistanceMin;
    }
    if (section==SECTION_FOOD) {
        return kDistance;
    }
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==SECTION_PAY) {
        return kCart_HEIGHT;
    }
    return CGFLOAT_MIN;
}
#pragma mark tableview delegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==SECTION_PAY) {
        UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kCart_HEIGHT)];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(kDistance, 0, 100, kCart_HEIGHT)];
        [label setTextColor:getUIColor(0x333333)];
        [label setFont:[UIFont LightFontOfSize:17]];
        [label setText:@"支付方式"];
        [header.layer addSublayer:getLine(0, kMainScreen_Width, kCart_HEIGHT, kCart_HEIGHT, getUIColor(0xdddddd))];
        [header addSubview:label];
        return header;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==SECTION_FOOD) {
        if (indexPath.row==_responseData.list.count) {
            return kCart_HEIGHT;
        }else{
            ChefItemTable *item=_responseData.list[indexPath.row];
            if (item.mname.length>0) {
                return 90;
            }else{
                return kCart_HEIGHT;
            }
        }
    }
    if (indexPath.section==SECTION_PAY) {
        return 60;
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
    if (indexPath.section==SECTION_ADDRESS) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setText:@"取餐地点"];
        [cell.textLabel setTextColor:getUIColor(0x333333)];
        [cell.textLabel setFont:[UIFont LightFontOfSize:17]];
        
        if (m_labAddress==nil) {
            m_labAddress=[[UILabel alloc]initWithFrame:CGRectMake(kMainScreen_Width-30-kMainScreen_Width*0.75, 0, kMainScreen_Width*0.75, kCart_HEIGHT)];
            [m_labAddress setTextColor:getUIColor(0x666666)];
            [m_labAddress setFont:[UIFont LightFontOfSize:15]];
            [m_labAddress setTextAlignment:NSTextAlignmentRight];
        }
        if (_address) {
            [m_labAddress setText:_address.addr];
        }else{
            [m_labAddress setText:@"选择取餐点"];
        }
        [cell addSubview:m_labAddress];
    }
    if (indexPath.section==SECTION_FOOD) {
        if (indexPath.row==_responseData.list.count) {
            if (m_labSub==nil) {
                m_labSub=[[UILabel alloc]initWithFrame:CGRectMake(kMainScreen_Width-Lab_Width-kDistance, 0, Lab_Width, kCart_HEIGHT)];
                [m_labSub setTextColor:getUIColor(0xff5436)];
                [m_labSub setFont:[UIFont FontOfSize:18]];
                [m_labSub setTextAlignment:NSTextAlignmentRight];
            }
            NSString *money=[NSString stringWithFormat:@"合计￥%@",_responseData.total];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont LightFontOfSize:16]
                                  range:NSMakeRange(0, 2)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:getUIColor(0x333333)
                                  range:NSMakeRange(0, 2)];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont FontOfSize:17]
                                  range:NSMakeRange(3, 1)];
            m_labSub.attributedText = AttributedStr;
            [cell addSubview:m_labSub];
        }else{
            ChefItemTable *item=_responseData.list[indexPath.row];
            if (item.mname.length>0) {
                TeamOrderBigCell *_cell = (TeamOrderBigCell *)[tableView dequeueReusableCellWithIdentifier:FoodBigCellIdentify forIndexPath:indexPath];
                _cell.selectionStyle=UITableViewCellSelectionStyleNone;
                _cell.category=_responseData.category;
                [_cell bindWith:item];
                cell=_cell;
            }else{
                TeamOrderCell *_cell = (TeamOrderCell *)[tableView dequeueReusableCellWithIdentifier:FoodCellIdentify forIndexPath:indexPath];
                _cell.labNameRight.constant=kDistanceMin;
                _cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [_cell bindWith:item];
                cell=_cell;
            }
        }
    }
    if (indexPath.section==SECTION_PAY) {
        ConfirmOrderPayCell *_cell = (ConfirmOrderPayCell *)[tableView dequeueReusableCellWithIdentifier:OrderPayCellIdentify forIndexPath:indexPath];
        _cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [_cell bindWithType:_responseData Row:indexPath.row];

        cell=_cell;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==SECTION_ADDRESS) {
        [self showAddressView];
    }
}
-(void)showAddressView
{
    if (m_addressView==nil) {
        m_addressView=[[AddressView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
    }
    m_addressView.arrList=_responseData.address;
    m_addressView.selectId=_address.Id;
    [m_addressView reloadDatas];
    [self.view.window addSubview:m_addressView];
    _showAddressView=YES;
    
    m_addressView.clickBlock = ^(TeamAddressTable *addr)
    {
        [m_addressView removeFromSuperview];
        _address=addr;
        [m_labAddress setText:addr.addr];
    };
    
}
-(void)confirmOrder:(UIButton *)button
{
    if (_address==nil) {
        [self showAddressView];
        return;
    }
    if(button.selected) return;
    button.selected=YES;
    
    NSMutableArray *arrFood=[NSMutableArray array];
    for (ChefItemTable *item in _responseData.list) {
        NSString *string=[NSString stringWithFormat:@"%@:%@",item.Id,item.num];
        [arrFood addObject:string];
    }
    
    SaveOrderRequest *request = [SaveOrderRequest new];
    request.items=[arrFood componentsJoinedByString:@";"];
    request.mealType=_mealType;
    request.date=_date;
    request.addrId=_address.Id;
    [cgClient doSaveOrder:request success:^(CGResponse *data, NSString *url) {
        SaveOrderResponse *response=[[SaveOrderResponse alloc]initWithCGResponse:data];
        if (self.backBlock) {
            self.backBlock(NO);
        }
        if (response.code.intValue==210) {
            TeamOrderPayVC *payVC=[[TeamOrderPayVC alloc]init];
            payVC.orderId=response.Id;
            payVC.goFirstVC=YES;
            [self.navigationController pushViewController:payVC animated:YES];
        }
        if (response.code.intValue==200) {
            TeamOrderDetailViewController *detailVC=[[TeamOrderDetailViewController alloc]init];
            detailVC.orderId=response.Id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        button.selected=NO;
    }];
}
-(void)goBack
{
    if (self.backBlock) {
        self.backBlock(YES);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end










