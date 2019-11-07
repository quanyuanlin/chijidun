#import "OrderListTableViewCellFooter.h"

@interface OrderListTableViewCellFooter()
{
    __block int stime;
}
@end

@implementation OrderListTableViewCellFooter
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect cellRect = self.frame;
    CGContextSetFillColorWithColor(context, BG_COLOR.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, cellRect.size.width, cellRect.size.height));
    
    [self.labTicket setFont:FONT_DEFAULT12];

    
    self.btnQFK.layer.cornerRadius = 5;
    [self.btnQFK setTintColor:MAIN_COLOR];
    self.btnQFK.layer.borderColor = MAIN_COLOR.CGColor;
    self.btnQFK.layer.borderWidth = 1;

    self.btnGBJY.layer.cornerRadius = 5;
    [self.btnGBJY setTintColor:TEXT_COLOR_DARK];
    self.btnGBJY.layer.borderColor = TEXT_COLOR_DARK.CGColor;
    self.btnGBJY.layer.borderWidth = 1;

    self.btnCKXQ.layer.cornerRadius = 5;
    [self.btnCKXQ setTintColor:TEXT_COLOR_DARK];
    self.btnCKXQ.layer.borderColor = TEXT_COLOR_DARK.CGColor;
    self.btnCKXQ.layer.borderWidth = 1;

    self.btnQRSH.layer.cornerRadius = 5;
    [self.btnQRSH setTintColor:MAIN_COLOR];
    self.btnQRSH.layer.borderColor = MAIN_COLOR.CGColor;
    self.btnQRSH.layer.borderWidth = 1;


    self.btnSCDD.layer.cornerRadius = 5;
    [self.btnSCDD setTintColor:TEXT_COLOR_DARK];
    self.btnSCDD.layer.borderColor = TEXT_COLOR_DARK.CGColor;
    self.btnSCDD.layer.borderWidth = 1;

}

- (void)bind {
    @weakify(self)
    [RACObserve(self, order)
            subscribeNext:^(id x) {
                @strongify(self);
                [self render];
            }];
}

- (void)unbind {
}

- (void)render {
    self.totalCount.text = [NSString stringWithFormat:@"共%ld件商品", (long) self.order.shop_item.cart_goods_list.count];
    self.totalFreight.text = [NSString stringWithFormat:@"￥%@", self.order.formated_shipping_fee];
    
    self.totalPrice.text=[NSString stringWithFormat:@"￥%.2f",[self.order.order_info.total_fee floatValue]];
    
    if ([self.order.formated_bonus floatValue]>0) {
        NSString *str=[NSString stringWithFormat:@"红包:￥-%d", self.order.formated_bonus.intValue];
        self.labTicket.text=str;
        NSMutableAttributedString *expressStr = [[NSMutableAttributedString alloc] initWithString:str];
        [expressStr addAttribute:NSForegroundColorAttributeName
                           value:COLOR_MID_GRAY
                           range:NSMakeRange(0, 3)];
        self.labTicket.attributedText = expressStr;
    }else{
        self.labTicket.hidden=YES;
    }
    
    //待付款
    if ([self.order.order_info.order_status isEqualToString:@"0"]) {
        [self.btnQFK setHidden:NO];
        self.ckxqMarginRight.constant = 10;
        
        if (stime==0) {
            stime=self.order.order_info.left_time.intValue;
            __block int timeout=stime;
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout==0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([self.delegate respondsToSelector:@selector(didFKJSTapped:)]) {
                            [self.delegate didFKJSTapped:self.order];
                        }
                        
                    });
                }else{
                    int minutes = timeout / 60;
                    int seconds = timeout % 60;
                    NSString *leftTime=[NSString stringWithFormat:@"去付款 %d:%d",minutes,seconds];
                    if (seconds<10) {
                        leftTime=[NSString stringWithFormat:@"去付款 %d:0%d",minutes,seconds];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.btnQFK setTitle:leftTime forState:UIControlStateNormal];
                    });
                    timeout--;
                    stime=timeout;
                }
            });
            dispatch_resume(_timer);
        }
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:YES];
        [self.btnGBJY setHidden:NO];
    }// 1已付款待接单
    else if ([self.order.order_info.order_status isEqualToString:@"1"]) {
        self.ckxqMarginRight.constant = 10;
        [self.btnQRSH setTitle:@"申请退款" forState:UIControlStateNormal];
        [self.btnQRSH setHidden:NO];
        [self.btnGBJY setHidden:YES];
        [self.btnQFK setHidden:YES];
        [self.btnSCDD setHidden:YES];
    } //2待配送
    else if ([self.order.order_info.order_status isEqualToString:@"2"]||[self.order.order_info.order_status isEqualToString:@"10"]) {
        [self.btnQFK setHidden:YES];
        self.ckxqMarginRight.constant = -80;
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:YES];
    } //待确认
    else if ([self.order.order_info.order_status isEqualToString:@"3"]) {
        [self.btnQRSH setTitle:@"确认收货" forState:UIControlStateNormal];
        [self.btnQFK setHidden:YES];
        self.ckxqMarginRight.constant = 10;
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:NO];
        [self.btnSCDD setHidden:YES];
    } //待评价
    else if ([self.order.order_info.order_status isEqualToString:@"4"]) {
        [self.btnQFK setHidden:YES];
        self.ckxqMarginRight.constant = 10;
        [self.btnQFK setHidden:YES];
        [self.btnQRSH setTitle:@"去评价" forState:UIControlStateNormal];
        [self.btnQRSH setHidden:NO];
        [self.btnGBJY setHidden:YES];
        [self.btnSCDD setHidden:YES];
        [self.btnSCDD setHidden:YES];
    } //已评价
    else if ([self.order.order_info.order_status isEqualToString:@"5"]) {
        self.ckxqMarginRight.constant = 10;
        [self.btnQRSH setTitle:@"查看评价" forState:UIControlStateNormal];
        [self.btnQFK setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:NO];
        [self.btnSCDD setHidden:YES];
    }
    else if ([self.order.order_info.order_status isEqualToString:@"6"]||[self.order.order_info.order_status isEqualToString:@"7"]) {
        self.ckxqMarginRight.constant = -80;
        self.scddMarginRight.constant=10;
        [self.btnQFK setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:NO];
    }
    else if ([self.order.order_info.order_status isEqualToString:@"11"]) {
        self.ckxqMarginRight.constant = 10;
        [self.btnQRSH setTitle:@"申请退款" forState:UIControlStateNormal];
        [self.btnQFK setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:NO];
        [self.btnSCDD setHidden:YES];
    }
    else {
        self.ckxqMarginRight.constant = -80;
        self.scddMarginRight.constant=10;
        [self.btnQFK setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:NO];
    }
}

//确认收货 去评价 查看评价 申请退款
- (IBAction)btnQRSHTapped:(id)sender {
    if ([self.order.order_info.order_status isEqualToString:@"3"]) {
        
        [UIAlertView_Extend showAlertWithTiTle:nil message:@"是否确认收货?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确认"] withCompletionBlock:^(NSInteger index) {
            if ([self.delegate respondsToSelector:@selector(didQRSHTaped:)]) {
                [self.delegate didQRSHTaped:self.order];
            }
        } andCancelBlock:^{
        } ];
    }else if ([self.order.order_info.order_status isEqualToString:@"4"]){
        if ([self.delegate respondsToSelector:@selector(didQPJTaped:)]) {
            [self.delegate didQPJTaped:self.order];
        }
    }else if ([self.order.order_info.order_status isEqualToString:@"5"]){
        if ([self.delegate respondsToSelector:@selector(didCKPJTaped:)]) {
            [self.delegate didCKPJTaped:self.order];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(didSQSHTaped:)]) {
            [self.delegate didSQSHTaped:self.order];
        }
    }
}

//提醒发货
- (IBAction)btnCKXQTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didCKXQTapped:)]) {
        [self.delegate didCKXQTapped:self.order];
    }
}

//去付款
- (IBAction)btnQFKTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didQFKTaped:)]) {
        [self.delegate didQFKTaped:self.order];
    }
}

//删除订单
- (IBAction)btnSCDDTapped:(id)sender {
    [UIAlertView_Extend showAlertWithTiTle:nil message:@"确认删除订单?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确认"] withCompletionBlock:^(NSInteger index) {
        if ([self.delegate respondsToSelector:@selector(didSCDDTaped:)]) {
            [self.delegate didSCDDTaped:self.order];
        }
    } andCancelBlock:^{
    } ];
}

//关闭交易订单
- (IBAction)btnGBJYTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didGBJYTaped:)]) {
        [self.delegate didGBJYTaped:self.order];
    }
}

- (IBAction)btnTXSCTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didTXSCTaped:)]) {
        [self.delegate didTXSCTaped:self.order];
    }
}
@end




