#import "OrderListViewController.h"

#define TableCellFooter @"OrderListTableViewCellFooter"
#define TableCellHeader @"OrderListTableViewCellHeader"
#define TableCell @"OrderListTableViewCell"

@implementation OrderListViewController {
    ThreeStageSegmentView *tssView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.filter = [FILTER new];
    }
    return self;
}

- (instancetype)initWithOrderStatus:(NSInteger)status {
    self = [self init];
    self.filter.status = [[NSNumber alloc] initWithInteger:status];
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setup {
    self.backend = [OrderBackend new];

    App *app = [App shared];
    @weakify(self)
    [RACObserve(app, currentUser) subscribeNext:^(USER *user) {
        @strongify(self);
        self.user = user;
        if ([user authorized]) {
            [self loadData];
            [ec.view removeFromSuperview];
        }
        else {
            ec = [EmptyViewController shared];
            ec.titleLabel.text = @"您还没有订单";
            ec.iconLable.text = @"\U0000B24A";
            ec.subTitleLabel.text = @"";
            ec.view.frame = self.tableView.frame;
            [self.view addSubview:[ec view]];
        }
    }];
    
    self.tableView.mj_header = refresh_header1;
    self.refreshBlock = ^{
        @strongify(self)
        [self loadData];
        [self.tableView.mj_header endRefreshing];
    };
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loadDataMore];
            [self.tableView.mj_footer endRefreshing];
        });
    }];

}

- (void)loadData {
    self.filter.pagenation.page = [[NSNumber alloc] initWithInt:1];
    [[self.backend requestOrderListWithUser:self.filter withUser:self.user]
            subscribeNext:[self didLoadData]];
}

- (void)loadDataMore {
    int p = [self.filter.pagenation.page intValue];
    p++;
    self.filter.pagenation.page = [[NSNumber alloc] initWithInt:p];
    [[self.backend requestOrderListWithUser:self.filter withUser:self.user]
            subscribeNext:[self didLoadDataMore]];
}

- (void (^)(RACTuple *))didLoadData {
    @weakify(self)
    return ^(RACTuple *parameters) {
        @strongify(self)
        RACTupleUnpack(FILTER *filter,
                NSArray *list) = parameters;
        self.filter = filter;
        self.datalist = [[NSMutableArray alloc] initWithArray:list];
        if (self.datalist.count > 0) {
            [self.tableView reloadData];
            [ec.view removeFromSuperview];
        }
        else {
            ec = [EmptyViewController shared];
            ec.view.frame = self.tableView.frame;
            ec.titleLabel.text = @"您还没有订单";
            ec.iconLable.text = @"\U0000B24A";
            ec.subTitleLabel.text = @"";
            ec.view.frame = self.tableView.frame;
            [self.view addSubview:[ec view]];
        }
    };
}

- (void (^)(RACTuple *))didLoadDataMore {
    @weakify(self)
    return ^(RACTuple *parameters) {
        @strongify(self)
        RACTupleUnpack(FILTER *filter,
                NSArray *list) = parameters;
        self.filter = filter;
        [self.datalist addObjectsFromArray:list];
        [self.tableView reloadData];
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.navigationItem.leftBarButtonItem = [self tbarBackButton];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.tableView.backgroundColor = BG_COLOR;

    tssView = [[ThreeStageSegmentView alloc] initWithButtonsName:@[@"全部", @"未完成", @"已完成", @"待评价",@"退款"] frame:CGRectMake(0, 0, screenSize.width, 40)];
    tssView.delegate = self;
    tssView.backgroundColor = WHITE_COLOR;
    [self.threeSegmentBtn addSubview:tssView];

    [tssView changeSelectedIndex:[self.filter.status integerValue]];

    [self.tableView registerNib:[UINib nibWithNibName:TableCell bundle:nil] forCellReuseIdentifier:TableCell];
    [self.tableView registerNib:[UINib nibWithNibName:TableCellHeader bundle:nil] forHeaderFooterViewReuseIdentifier:TableCellHeader];
    [self.tableView registerNib:[UINib nibWithNibName:TableCellFooter bundle:nil] forHeaderFooterViewReuseIdentifier:TableCellFooter];

    [self setup];
}
-(void)goBack
{
    if (_isFromPay) {
        if (_backType==5) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            UDNavigationController *navi=(UDNavigationController *)self.parentViewController;
            [navi.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            [[AppDelegate appDelegate] setTabVCWith:3];
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark- ThreeStageSegmentViewDelegate

- (void)threeStageSegmentView:(ThreeStageSegmentView *)segment
             didSelectAtIndex:(NSInteger)index {
    self.filter.pagenation.page = [[NSNumber alloc] initWithInt:1];
    switch (index) {
        case 1:
            self.filter.status = [[NSNumber alloc] initWithInt:1];
            break;
        case 2:
            self.filter.status = [[NSNumber alloc] initWithInt:2];
            break;
        case 3:
            self.filter.status = [[NSNumber alloc] initWithInt:3];
            break;
        case 4:
            self.filter.status = [[NSNumber alloc] initWithInt:4];
            break;
        case 0:
        default:
            self.filter.status = nil;
            break;
    }
    [[self.backend requestOrderListWithUser:self.filter withUser:self.user]
            subscribeNext:[self didLoadData]];
}


#pragma mark Table Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datalist.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.datalist.count>0){
        ORDER *od = self.datalist[section];
        return od.shop_item.cart_goods_list.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderListTableViewCell *cell = (OrderListTableViewCell *) [tableView dequeueReusableCellWithIdentifier:TableCell forIndexPath:indexPath];
    if(self.datalist.count>0){
        ORDER *item = self.datalist[indexPath.section];
        cell.cartItem = item.shop_item.cart_goods_list[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell bind];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ORDER *order=self.datalist[indexPath.section];
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc] initWithOrderId:order.rec_id];
    detailVC.refundBlock=^()
    {
        [self clickRefundButton];
    };
    [self showNavigationView:detailVC];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 100.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrderListTableViewCellHeader *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:TableCellHeader];
    view.delegate=self;
    if(self.datalist.count>0){
        ORDER *o = self.datalist[section];
        view.order = o;
        view.order.shop_item.section = section;
        [view bind];
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    OrderListTableViewCellFooter *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:TableCellFooter];
    if(self.datalist.count>0){
        ORDER *o = self.datalist[section];
        view.order = o;
        view.delegate = self;
        view.shop_item = o.shop_item;
        view.order.shop_item.section = section;
        [view bind];
    }
    return view;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma OrderListTableViewCellFooterDelegate

- (void)didQFKTaped:(ORDER *)anOrder {
    PaymentViewController *payVC = [[PaymentViewController alloc] initWithOrder:anOrder];
    [self.navigationController pushViewController:payVC animated:YES];
}

- (void)didCKXQTapped:(ORDER *)anOrder {
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc] initWithOrderId:anOrder.rec_id];
    detailVC.refundBlock=^()
    {
        [self clickRefundButton];
    };
    [self showNavigationView:detailVC];
}

- (void)didQRSHTaped:(ORDER *)anOrder {
    [[self.backend requestConfirmOrder:anOrder]
            subscribeNext:[self didUpdate:@"确认收货成功"]];
    [tssView changeSelectedIndex:3];
}

- (void)didGBJYTaped:(ORDER *)anOrder {
    [[self.backend requestCloseOrder:anOrder]
            subscribeNext:[self didUpdate:@"关闭交易成功"]];
}
-(void)didFKJSTapped:(ORDER *)anOrder
{
    [self loadData];
    [tssView changeSelectedIndex:0];
}
- (void (^)(RACTuple *))didUpdate:(NSString *)text {
    @weakify(self)
    return ^(RACTuple *parameters) {
        @strongify(self)
        ResponseResult *rs = (ResponseResult *) parameters;
        if (rs.success) {
            [self.view showHUD:text];
            [self loadData];
        }
        else {
            [self.view showHUD:rs.messge];
        }
        [self.tableView reloadData];

    };
}

- (void)didSCDDTaped:(ORDER *)anOrder {
    OrderDeleteRequest *request = [OrderDeleteRequest new];
    request.Id = toNSString(anOrder.rec_id);
    [apiClient doOrderDelete:request success:^(NSMutableDictionary *_data, NSString *url) {
        [self.view showHUD:@"删除成功"];
        [self loadData];
    }];
}

- (void)didTXSCTaped:(ORDER *)anOrder {

}
-(void)didCKPJTaped:(ORDER *)anOrder
{
    MyCommentsViewController *detail = [[MyCommentsViewController alloc] init];
    [self showNavigationView:detail];
}
- (void)didQPJTaped:(ORDER *)anOrder {
    CommentViewController *commentView = [[CommentViewController alloc] init];
    commentView.order = anOrder;
    [self showNavigationView:commentView];
}
-(void)didSQSHTaped:(ORDER *)anOrder
{
    [UIAlertView_Extend showAlertWithTiTle:nil message:@"确定申请退款?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确认"] withCompletionBlock:^(NSInteger index) {
        [self refundOrderWith:anOrder];
    } andCancelBlock:^{
    } ];
}
-(void)refundOrderWith:(ORDER *)order
{
    OrderRefundRequest *request = [OrderRefundRequest new];
    request.Id=toNSString(order.rec_id);
    [apiClient doOrderRefund:request success:^(NSMutableDictionary *_data, NSString *url) {
        [self clickRefundButton];
    }];
}
-(void)ClickOrderListTableViewCellHeader:(ORDER *)anOrder
{
    if (anOrder.order_info.is_check.intValue==1) {
        ChefDetailVC *detailVC = [[ChefDetailVC alloc]init];
        detailVC.Id=[NSString stringWithFormat:@"%@",anOrder.order_info.member_id];
        detailVC.isFaverVC=YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        [self.view showHUD:@"该私厨已下架"];
    }
    
}
-(void)clickRefundButton
{
    [self loadData];
    [tssView changeSelectedIndex:4];
}
@end








