//
//  PayResultViewController.m
//  chijidun
//
//  Created by iMac on 16/11/18.
//
//

#import "PayResultViewController.h"

#define IMG_WIDTH S(85)
#define IMG_HEIGHT S(120)
@interface PayResultViewController ()
{
    UIImageView *m_resultView;
    UILabel *m_labTitle;
    UILabel *m_labDesc;
    UIButton *m_btnBack;
    UILabel *m_labTime;
    
    UIButton *m_btnDetail;
}
@end

@implementation PayResultViewController
- (instancetype)initWithOrderTable:(OrderTable *)order
{
    self = [self init];
    if (self) {
        self.order=[[OrderTable alloc]init];
        self.order = order;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_isSuccess?@"购买成功":@"购买失败";
    
    [self addMainView];
    [self loadOrderData];
}
-(void)loadOrderData
{
    OrderGetRequest *request=[OrderGetRequest new];
    request.Id = self.order.Id;
    [apiClient doOrderGet:request success:^(NSMutableDictionary *_data, NSString *url) {
        OrderGetResponse *response=[[OrderGetResponse new]fromJSON:_data];
        _order=response.data;
        NSString *orderTime=[NSString stringWithFormat:@"支付时间 %@",_order.pays_time];
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc]initWithString:orderTime];
        [attriStr addAttribute:NSForegroundColorAttributeName
                         value:TEXT_DEEP
                         range:NSMakeRange(0, 4)];
        [attriStr addAttribute:NSFontAttributeName
                         value:[UIFont LightFontOfSize:17]
                         range:NSMakeRange(0, 4)];
        m_labTime.attributedText = attriStr;
    }];
}
-(void)addMainView
{
    [self.view setBackgroundColor:WHITE_COLOR];
    CGFloat width=IMG_WIDTH;
    if (!_isSuccess) {
        width=S(130);
    }
    CGFloat left=(kMainScreen_Width-width)/2;
    m_resultView=[[UIImageView alloc]initWithFrame:CGRectMake(left, S(50), width, IMG_HEIGHT)];
    [self.view addSubview:m_resultView];
    
    m_labTitle=[[UILabel alloc]initWithFrame:CGRectMake(kMainScreen_Width*0.1, CGRectGetMaxY(m_resultView.frame)+S(2*kDistance), kMainScreen_Width*0.8, 20)];
    [m_labTitle setTextAlignment:NSTextAlignmentCenter];
    [m_labTitle setFont:[UIFont LightFontOfSize:20]];
    [m_labTitle setTextColor:getUIColor(0x333333)];
    [self.view addSubview:m_labTitle];
    
    if (_isSuccess) {
        [m_resultView setImage:[UIImage imageNamed:@"order_success"]];
        [m_labTitle setText:@"购买成功"];
        [m_labTitle setTextColor:GREEN_COLOR];
        
        CGFloat line1Y=CGRectGetMaxY(m_labTitle.frame)+S(40);
        CGFloat line2Y=CGRectGetMaxY(m_labTitle.frame)+S(40+100);
        
        CGFloat left2=S(75/2);
        [self.view.layer addSublayer:getLine(left2, kMainScreen_Width-left2, line1Y, line1Y, getUIColor(0xdddddd))];
        [self.view.layer addSublayer:getLine(left2, kMainScreen_Width-left2, line2Y, line2Y, getUIColor(0xdddddd))];
        
        m_labDesc=[[UILabel alloc]initWithFrame:CGRectMake(left2, line1Y+S(25), kMainScreen_Width-2*left2, 20)];
        [m_labDesc setFont:[UIFont LightFontOfSize:16]];
        [m_labDesc setTextColor:TEXT_MIDDLE];
        [self.view addSubview:m_labDesc];
        NSString *orderNum=[NSString stringWithFormat:@"订单编号 %@",_order.orderid];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:orderNum];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:TEXT_DEEP
                              range:NSMakeRange(0, 4)];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont LightFontOfSize:16]
                              range:NSMakeRange(0, 4)];
        m_labDesc.attributedText = AttributedStr;
        
        
        m_labTime=[[UILabel alloc]initWithFrame:CGRectMake(left2, CGRectGetMaxY(m_labDesc.frame)+S(kDistance), kMainScreen_Width-2*left2, 20)];
        [m_labTime setFont:[UIFont LightFontOfSize:16]];
        [m_labTime setTextColor:TEXT_MIDDLE];
        [self.view addSubview:m_labTime];
        
        m_btnDetail=[[UIButton alloc]initWithFrame:CGRectMake(left2, line2Y+S(2*kDistance), kMainScreen_Width-2*left2, 40)];
        [m_btnDetail setTitle:@"查看订单详情" forState:UIControlStateNormal];
        [m_btnDetail.titleLabel setFont:[UIFont LightFontOfSize:17]];
        [m_btnDetail setBackgroundColor:getUIColor(0xff9a00)];
        [m_btnDetail setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        m_btnDetail.layer.cornerRadius=5.0f;
        [self.view addSubview:m_btnDetail];
        [m_btnDetail addTarget:self action:@selector(detailBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        m_btnBack=[[UIButton alloc]initWithFrame:CGRectMake(left2, CGRectGetMaxY(m_btnDetail.frame)+S(kDistance), kMainScreen_Width-2*left2, 40)];
        [m_btnBack.titleLabel setFont:[UIFont LightFontOfSize:17]];
        [m_btnBack setTitle:@"返回" forState:UIControlStateNormal];
        [m_btnBack setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
        m_btnBack.layer.cornerRadius=5.0f;
        m_btnBack.layer.borderColor=YELLOW_COLOR.CGColor;
        m_btnBack.layer.borderWidth=1.0f;
        [self.view addSubview:m_btnBack];
        [m_btnBack addTarget:self action:@selector(goListVC) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        CGFloat line1Y=CGRectGetMaxY(m_labTitle.frame)+S(40);
        CGFloat line2Y=CGRectGetMaxY(m_labTitle.frame)+S(40+70);
        
        CGFloat left2=S(75/2);
        [self.view.layer addSublayer:getLine(left2, kMainScreen_Width-left2, line1Y, line1Y, getUIColor(0xdddddd))];
        [self.view.layer addSublayer:getLine(left2, kMainScreen_Width-left2, line2Y, line2Y, getUIColor(0xdddddd))];
        
        m_labDesc=[[UILabel alloc]initWithFrame:CGRectMake(left2, line1Y+S(25), kMainScreen_Width-2*left2, 20)];
        [m_labDesc setFont:[UIFont LightFontOfSize:16]];
        [m_labDesc setTextColor:TEXT_MIDDLE];
        [self.view addSubview:m_labDesc];
        
        m_btnBack=[[UIButton alloc]initWithFrame:CGRectMake(left2, line2Y+S(50), kMainScreen_Width-2*left2, 40)];
        [m_btnBack setTitle:@"返回" forState:UIControlStateNormal];
        [m_btnBack setBackgroundColor:getUIColor(0xff9a00)];
        [m_btnBack setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        [m_btnBack.titleLabel setFont:[UIFont LightFontOfSize:17]];
        m_btnBack.layer.cornerRadius=5.0f;
        [self.view addSubview:m_btnBack];
        [m_btnBack addTarget:self action:@selector(detailBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [m_resultView setImage:[UIImage imageNamed:@"order_fail"]];
        [m_labTitle setText:@"购买失败"];
        [m_labTitle setTextColor:RED_COLOR];
        
        NSString *failer=@"原因 支付出现错误或者用户取消支付";
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:failer];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont LightFontOfSize:17]
                              range:NSMakeRange(0, 2)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:TEXT_DEEP
                              range:NSMakeRange(0, 2)];
        [m_labDesc setAttributedText:AttributedStr];
    }
}
-(void)backBtnClicked:(id)sender
{
    if (_isCheckOut) {
        UDNavigationController *navi=(UDNavigationController *)self.parentViewController;
        [navi.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)detailBtnClicked:(id)sender
{
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc] initWithOrderId:self.order.Id With:_isCheckOut];
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)goListVC
{
    OrderListViewController *listVC = [[OrderListViewController alloc] init];
    listVC.isFromPay=YES;
    if (!_isCheckOut) {
        listVC.backType=5;
    }    
    [self.navigationController pushViewController:listVC animated:YES];
}
@end



