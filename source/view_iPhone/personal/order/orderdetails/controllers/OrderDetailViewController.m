//
//  OrderDetailViewController.m
//  insuny
//
//  Created by txj on 15/5/18.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "OrderDetailViewController.h"

#define TableCellButtomBarFooter @"OrderButtomBarTableViewCellFooter"
#define TableCellFooter @"OrderDetailTableViewCellFooter"
#define TableCellFooter2 @"OrderDetailViewCellFooter2"
#define TableCellHeader @"OrderDetailTableViewCellHeader"
#define TableCell @"OrderListTableViewCell"
#define TableCellSeciton1 @"AddressTableViewCell"
#define TableCellSection4 @"OrderDetailSection4TableViewCell"
#define TableCellSection5 @"OrderStatusTableViewCell"

@interface OrderDetailViewController ()
{
    BOOL _isPayVC;
}
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单详情";
    self.navigationItem.leftBarButtonItem = [self tbarBackButton];

    [self loadOrderData];
    self.tableView.backgroundColor = BG_COLOR;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -40, 0);
    [self.tableView registerNib:[UINib nibWithNibName:TableCellSeciton1 bundle:nil] forCellReuseIdentifier:TableCellSeciton1];
    [self.tableView registerNib:[UINib nibWithNibName:TableCellSection4 bundle:nil] forCellReuseIdentifier:TableCellSection4];
    [self.tableView registerNib:[UINib nibWithNibName:TableCellSection5 bundle:nil] forCellReuseIdentifier:TableCellSection5];
    [self.tableView registerNib:[UINib nibWithNibName:TableCell bundle:nil] forCellReuseIdentifier:TableCell];
    [self.tableView registerNib:[UINib nibWithNibName:TableCellHeader bundle:nil] forHeaderFooterViewReuseIdentifier:TableCellHeader];
    [self.tableView registerNib:[UINib nibWithNibName:TableCellFooter bundle:nil] forHeaderFooterViewReuseIdentifier:TableCellFooter];
    [self.tableView registerNib:[UINib nibWithNibName:TableCellButtomBarFooter bundle:nil] forHeaderFooterViewReuseIdentifier:TableCellButtomBarFooter];
    [self.tableView registerNib:[UINib nibWithNibName:TableCellFooter2 bundle:nil] forHeaderFooterViewReuseIdentifier:TableCellFooter2];

}
- (instancetype)initWithOrderId:(NSString *)orderid With:(BOOL)isPayVC{
    self = [super init];
    if (self) {
        _isPayVC=isPayVC;
        self.order = [[ORDER alloc]init];
        self.order.rec_id=orderid;
        self.backend = [OrderBackend new];
    }
    return self;
}
- (instancetype)initWithOrderId:(NSString *)orderid
{
    self = [super init];
    if (self) {
        self.order = [[ORDER alloc]init];
        self.order.rec_id=orderid;
        self.backend = [OrderBackend new];
    }
    return self;
}
-(void)loadOrderData
{
    OrderGetRequest *request=[OrderGetRequest new];
    request.Id = toNSString(self.order.rec_id);
    [apiClient doOrderGet:request success:^(NSMutableDictionary *_data, NSString *url) {
        OrderGetResponse *response=[[OrderGetResponse new]fromJSON:_data];
        OrderTable *anOrder=response.data;
        
        self.order.order_info.order_status=anOrder.status;
        self.order.address_item.address=anOrder.addr_address;
        self.order.address_item.province_name=anOrder.addr_province;
        self.order.address_item.city_name=anOrder.addr_city;
        self.order.address_item.district_name=anOrder.addr_area;
        self.order.address_item.zipcode=anOrder.addr_zipcode;
        self.order.address_item.tel=anOrder.addr_tele;
        self.order.address_item.consignee=anOrder.addr_name;
        
        self.order.order_info.order_id=anOrder.orderid;
        self.order.order_info.check_time=anOrder.check_time;
        self.order.order_info.days=anOrder.days;
        self.order.order_info.times=anOrder.times;
        self.order.order_info.htotal=anOrder.htotal;
        self.order.order_info.member_id=anOrder.mid;
        self.order.order_info.member_title=anOrder.mname;
        self.order.order_info.member_tele=anOrder.member_tele;
        self.order.order_info.pays=anOrder.pays;
        self.order.order_info.pays_id=anOrder.pays_id;
        self.order.order_info.pay_time=anOrder.pays_time;
        self.order.order_info.pay_code=anOrder.pays_sn;
        self.order.order_info.order_status=anOrder.status;
        self.order.order_info.order_time=anOrder.add_time;
        self.order.order_info.total_fee=anOrder.pays_price;
        self.order.order_info.remark=anOrder.remark;
        self.order.order_info.express_tele=anOrder.express_tele;
        self.order.order_info.express_type=anOrder.express_type;
        self.order.order_info.pay_code=anOrder.trade_no;
        self.order.formated_bonus=anOrder.quan_price;
        self.order.formated_shipping_fee=anOrder.express;
        self.order.order_info.total_fee=anOrder.total;
        
        self.order.shipping_item.shipping_desc=anOrder.express_remark;
        self.order.shipping_item.shipping_sn=anOrder.express_sn;
        self.order.shipping_item.shipping_name=anOrder.express_name;
        self.order.shipping_item.shipping_time=anOrder.express_time;
        
        self.order.shop_item=[[SHOP_ITEM alloc]init];
        self.order.shop_item.cart_goods_list=[NSMutableArray array];
        NSArray *array=[NSArray arrayWithArray:anOrder.items];
        for (Order_itemTable *item in array) {
            CART_GOODS *cd=[CART_GOODS new];
            cd.goods_name = item.title;
            cd.goods_price=item.price.floatValue;
            cd.goods_number=item.num.integerValue;
            cd.goods_strattr=item.attr;
            cd.img.small=item.item_img;
            [self.order.shop_item.cart_goods_list addObject:cd];
        }
        [self.tableView reloadData];
    }];
}
- (void)goBack {
    if (_isPayVC) {
        OrderListViewController *uc = [[OrderListViewController alloc]init];
        uc.isFromPay=_isPayVC;
        [self.navigationController pushViewController:uc animated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark Table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 5;
    }
    if (section == 3) {
        if (self.order.order_info.order_id) {
            NSInteger count = self.order.shop_item.cart_goods_list.count;
            return count;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *_cell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            OrderStatusTableViewCell *cell = (OrderStatusTableViewCell *) [tableView dequeueReusableCellWithIdentifier:TableCellSection5 forIndexPath:indexPath];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (self.order.order_info.order_id) {
                cell.order = self.order;
                [cell setOrderStatus];
            }
            _cell = cell;
        }
        if (indexPath.row == 1) {
            AddressTableViewCell *cell = (AddressTableViewCell *) [tableView dequeueReusableCellWithIdentifier:TableCellSeciton1 forIndexPath:indexPath];
            if (self.order.order_info.order_id) {
                cell.address = self.order.address_item;
                cell.coverImage.image = [UIImage imageNamed:@"0142108.png"];
                [cell bind];
            }
            _cell = cell;
        }
    }
    if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];

        NSArray *array = @[@"私厨电话",@"派送员电话", @"配送方式", @"就餐时间", @"支付方式"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreen_Width * 0.03, 0, kMainScreen_Width * 0.25, 40)];
        [label setFont:FONT_DEFAULT15];
        [label setText:array[indexPath.row]];
        [cell addSubview:label];
        NSString *express_type;
        if (self.order.order_info.express_type.intValue==1) {
            express_type = @"私厨送货";
        }else if (self.order.order_info.express_type.intValue==2){
            express_type = @"第三方物流配送";
        }else if (self.order.order_info.express_type.intValue==0)
        {
           express_type= @"";
        }
        
        NSString *payType=@"";
        if (self.order.order_info.pays.intValue==3) {
            payType = @"支付宝";
        }
        if (self.order.order_info.pays.intValue==4) {
            payType = @"微信";
        }
        NSString *string= [self.order.order_info.days substringFromIndex:5];
        NSString *time = [NSString stringWithFormat:@"%@ %@", string, self.order.order_info.times];

        if (self.order.order_info.member_tele.length==0) {
            self.order.order_info.member_tele=@"";
        }
        
        if (self.order.order_info.order_id) {
            NSArray *detailArray = @[self.order.order_info.member_tele,self.order.order_info.express_tele, express_type, time, payType];
            
            UILabel *labDetail = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreen_Width * 0.3, 0, kMainScreen_Width * 0.68, 40)];
            [labDetail setTextColor:COLOR_MID_GRAY];
            [labDetail setFont:FONT_DEFAULT15];
            labDetail.text = detailArray[indexPath.row];
            [cell addSubview:labDetail];
        }

        _cell = cell;
    }
    if (indexPath.section == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        NSString *string = self.order.order_info.remark;

        CGSize Size = [string boundingRectWithSize:CGSizeMake(kMainScreen_Width * 0.94, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : FONT_DEFAULT15} context:nil].size;

        UILabel *labNote = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreen_Width * 0.03, 10, kMainScreen_Width * 0.94, Size.height)];
        [labNote setTextColor:COLOR_MID_GRAY];
        [labNote setFont:FONT_DEFAULT15];
        [labNote setNumberOfLines:0];
        labNote.text = string;
        [cell addSubview:labNote];

        _cell = cell;
    }
    if (indexPath.section == 3) {
        OrderListTableViewCell *cell = (OrderListTableViewCell *) [tableView dequeueReusableCellWithIdentifier:TableCell forIndexPath:indexPath];
        if (self.order.order_info.order_id) {
            SHOP_ITEM *item = self.order.shop_item;
            cell.cartItem = [item.cart_goods_list objectAtIndex:indexPath.row];
            cell.cartItem.indexPath = indexPath;
            [cell bind];
        }
        _cell = cell;
    }
    if (indexPath.section == 4) {
        OrderDetailSection4TableViewCell *cell = (OrderDetailSection4TableViewCell *) [tableView dequeueReusableCellWithIdentifier:TableCellSection4 forIndexPath:indexPath];
        if (self.order.order_info.order_id) {
            cell.order = self.order;
            [cell bind];
        }
        _cell = cell;
    }
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 75;
    }
    if (indexPath.section == 2) {
        NSString *string = self.order.order_info.remark;
        CGFloat stringHeight = [string boundingRectWithSize:CGSizeMake(kMainScreen_Width * 0.94, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : FONT_DEFAULT15} context:nil].size.height;
        return stringHeight + 20;
    }
    if (indexPath.section == 3) {
        return 75;
    }
    if (indexPath.section == 4) {
        return 145;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 30;
    }
    if (section == 3) {
        return 40;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 20)];
        [header setBackgroundColor:BG_COLOR];

        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(kMainScreen_Width * 0.03, 5, 35, 20)];
        [header addSubview:lab];
        [lab setFont:FONT_DEFAULT15];
        [lab setText:@"备注"];
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lab.frame)+5, 5, 120, 20)];
        [header addSubview:lab2];
        [lab2 setFont:FONT_DEFAULT15];
        [lab2 setTextColor:COLOR_MID_GRAY];
        [lab2 setText:@"（选填0-50字）"];
        return header;
    }
    if (section == 3) {
        OrderDetailTableViewCellHeader *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:TableCellHeader];
        if (self.order.order_info.order_id) {
            view.order = self.order;
            view.shop_item = self.order.shop_item;
            view.shop_item.section = section;
            [view bind];
        }
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10.0f;
    }
    if (section == 2) {
        return 10.0f;
    }
    if (section == 3) {
        if ([self.order.formated_bonus floatValue]>0) {
            return 70;
        }
        return 40;
    }
    if (section == 4) {
        return 60;
    }
    return 1.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 10)];
        [footer setBackgroundColor:BG_COLOR];
    }
    if (section == 3) {
       if ([self.order.formated_bonus floatValue]>0) {
            OrderDetailViewCellFooter2 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:TableCellFooter2];
           if (self.order.order_info.order_id) {
               view.order = self.order;
               view.shop_item = self.order.shop_item;
               view.shop_item.section = section;
               [view bind];
           }
            return view;
        }else{
        OrderDetailTableViewCellFooter *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:TableCellFooter];
        if (self.order.order_info.order_id){
        view.order = self.order;
        view.shop_item = self.order.shop_item;
        view.shop_item.section = section;
        [view bind];
        }
        return view;
        }
    }
    if (section == 4) {
        OrderButtomBarTableViewCellFooter *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:TableCellButtomBarFooter];
        if (self.order.order_info.order_id){
        view.order = self.order;
        view.delegate = self;
        [view bind];
        }
        return view;
    } else {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 10)];
        [footer setBackgroundColor:BG_COLOR];
        return footer;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            if (self.order.order_info.member_tele.length>0) {
                [self showPhoneWith:self.order.order_info.member_tele andTag:indexPath.row+100];
            }
        }
        if (indexPath.row==1) {
            if (self.order.order_info.express_tele.length>0) {
                [self showPhoneWith:self.order.order_info.express_tele andTag:indexPath.row+100];
            }
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (MODEL_VERSION >= 7.0) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if (MODEL_VERSION >= 8.0) {
            if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
                [cell setPreservesSuperviewLayoutMargins:NO];
            }
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
            }
        }
    }
    
}
-(void)showPhoneWith:(NSString *)phone andTag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:phone message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    alert.tag=tag;
    [alert show];
}
#pragma OrderListTableViewCellFooterDelegate

- (void)didQFKTaped:(ORDER *)anOrder {
    PaymentViewController *payVC = [[PaymentViewController alloc] initWithOrder:anOrder];
    [self.navigationController pushViewController:payVC animated:YES];
}

- (void)didQRSHTaped:(ORDER *)anOrder {
    [[self.backend requestConfirmOrder:anOrder]
            subscribeNext:[self didUpdate:@"确认收货成功"]];
}

- (void)didGBJYTaped:(ORDER *)anOrder {
    [[self.backend requestCloseOrder:anOrder]
            subscribeNext:[self didUpdate:@"关闭交易成功"]];
}

- (void)didQPJTaped:(ORDER *)anOrder {
    CommentViewController *commentView = [[CommentViewController alloc] init];
    commentView.order = self.order;
    [self showNavigationView:commentView];
}
-(void)didSQSHTaped:(ORDER *)anOrder
{
    [UIAlertView_Extend showAlertWithTiTle:@"确定申请退款?" message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"确认"] withCompletionBlock:^(NSInteger index) {
        [self refundOrderWith:anOrder];
    } andCancelBlock:^{
    } ];
}
-(void)refundOrderWith:(ORDER *)order
{
    OrderRefundRequest *request = [OrderRefundRequest new];
    request.Id=toNSString(order.rec_id);
    [apiClient doOrderRefund:request success:^(NSMutableDictionary *_data, NSString *url) {
        if (self.refundBlock) {
            self.refundBlock();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self goBack];
        });
    }];
}

- (void (^)(RACTuple *))didUpdate:(NSString *)text {
    @weakify(self)
    return ^(RACTuple *parameters) {
        @strongify(self)
        ResponseResult *rs = (ResponseResult *) parameters;
        if (rs.success) {
            [self.view showHUD:text];
            self.order.order_info.order_status = @"5";
            [self.tableView reloadData];
        }
        else {
            [self.view showHUD:rs.messge];
        }
        [self.tableView reloadData];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];

    };
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 60;
    if (scrollView.contentOffset.y <= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, -sectionHeaderHeight, 0);
    } else if (scrollView.contentOffset.y >= 100) {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, -10, 0);
    }
}

#pragma mark -alertview delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag==100) {
        if (buttonIndex == 1) {
            NSString *urlString = [NSString stringWithFormat:@"tel://%@",self.order.order_info.member_tele];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    }else{
        if (buttonIndex==101) {
            NSString *urlString = [NSString stringWithFormat:@"tel://%@",self.order.order_info.express_tele];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }
    }
}

@end



