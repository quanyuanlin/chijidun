//
//  CartTableViewCellFooter.m
//  insuny
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "OrderButtomBarTableViewCellFooter.h"

@interface OrderButtomBarTableViewCellFooter()
{
    __block int stime;
}
@end
@implementation OrderButtomBarTableViewCellFooter

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect cellRect = self.frame;
    CGContextSetFillColorWithColor(context, BG_COLOR.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, cellRect.size.width, cellRect.size.height));
    
    self.btnQFK.layer.cornerRadius=5;
    [self.btnQFK setTintColor:MAIN_COLOR];
    self.btnQFK.layer.borderColor=MAIN_COLOR.CGColor;
    self.btnQFK.layer.borderWidth=1;
    
    self.self.btnCKXQ.layer.cornerRadius=5;
    [self.self.btnCKXQ setTintColor:TEXT_COLOR_DARK];
    self.self.btnCKXQ.layer.borderColor=TEXT_COLOR_DARK.CGColor;
    self.self.btnCKXQ.layer.borderWidth=1;
    
    self.btnGBJY.layer.cornerRadius=5;
    [self.btnGBJY setTintColor:TEXT_COLOR_DARK];
    self.btnGBJY.layer.borderColor=TEXT_COLOR_DARK.CGColor;
    self.btnGBJY.layer.borderWidth=1;
    
    self.btnQRSH.layer.cornerRadius=5;
    [self.btnQRSH setTintColor:MAIN_COLOR];
    self.btnQRSH.layer.borderColor=MAIN_COLOR.CGColor;
    self.btnQRSH.layer.borderWidth=1;

    self.btnSCDD.layer.cornerRadius=5;
    [self.btnSCDD setTintColor:MAIN_COLOR];
    self.btnSCDD.layer.borderColor=MAIN_COLOR.CGColor;
    self.btnSCDD.layer.borderWidth=1;
    
    self.btnSCDD.layer.cornerRadius=5;
    [self.btnSCDD setTintColor:TEXT_COLOR_DARK];
    self.btnSCDD.layer.borderColor=TEXT_COLOR_DARK.CGColor;
    self.btnSCDD.layer.borderWidth=1;

    [self.btnQPJ.titleLabel setFont:FONT_DEFAULT12];
    self.btnQPJ.layer.cornerRadius=5;
    [self.btnQPJ setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    self.btnQPJ.layer.borderColor=MAIN_COLOR.CGColor;
    self.btnQPJ.layer.borderWidth=1;
    [self.btnQPJ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnCKWL).offset(90);
        make.centerY.equalTo(self.btnCKWL);
        make.height.equalTo(@25);
        make.width.equalTo(@80);
    }];
    
    self.btnCKWL.layer.cornerRadius=5;
    [self.btnCKWL setTintColor:TEXT_COLOR_DARK];
    self.btnCKWL.layer.borderColor=TEXT_COLOR_DARK.CGColor;
    self.btnCKWL.layer.borderWidth=1;
    
    [self.btnYWC.titleLabel setFont:FONT_DEFAULT12];
    self.btnYWC.layer.cornerRadius=5;
    [self.btnYWC setTitleColor:TEXT_COLOR_DARK forState:UIControlStateNormal];
    self.btnYWC.layer.borderColor=TEXT_COLOR_DARK.CGColor;
    self.btnYWC.layer.borderWidth=1;
    [self.btnYWC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnCKWL).offset(90);
        make.centerY.equalTo(self.btnCKWL);
        make.height.equalTo(@25);
        make.width.equalTo(@80);
    }];
    
    [self.btnYGB.titleLabel setFont:FONT_DEFAULT12];
    self.btnYGB.layer.cornerRadius=5;
    [self.btnYGB setTitleColor:TEXT_COLOR_DARK forState:UIControlStateNormal];
    self.btnYGB.layer.borderColor=TEXT_COLOR_DARK.CGColor;
    self.btnYGB.layer.borderWidth=1;
    [self.btnYGB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnCKWL).offset(90);
        make.centerY.equalTo(self.btnCKWL);
        make.height.equalTo(@25);
        make.width.equalTo(@80);
    }];
    
}
- (void)bind
{
    @weakify(self)
    [RACObserve(self, order)
     subscribeNext:^(id x) {
         @strongify(self);
         [self render];
     }];
}

- (void)unbind
{
}
-(void)render
{
    if ([self.order.order_info.order_status isEqualToString:@"0"]) {
        
        if (stime==0) {
            stime=self.order.order_info.left_time.intValue;
            __block int timeout=stime;
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
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

        [self.btnQFK setHidden:NO];
        self.gbjyMarginRight.constant=10;
        [self.btnCKXQ setHidden:YES];
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:YES];
        [self.btnQPJ setHidden:YES];
        [self.btnYWC setHidden:YES];
        [self.btnCKWL setHidden:YES];
        [self.btnCKPJ setHidden:YES];
        [self.btnYGB setHidden:YES];
    }//待接单
    else if ([self.order.order_info.order_status isEqualToString:@"1"]) {
        self.ckxqMarginRight.constant = 100;
        [self.btnQPJ setTitle:@"申请退款" forState:UIControlStateNormal];
        [self.btnQFK setHidden:YES];
        [self.btnCKXQ setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:YES];
        [self.btnQPJ setHidden:NO];
        [self.btnYWC setHidden:YES];
        [self.btnCKWL setHidden:YES];
        [self.btnCKPJ setHidden:YES];
        [self.btnYGB setHidden:YES];
    }//待确认
    else if ([self.order.order_info.order_status isEqualToString:@"2"]) {
        [self.btnQFK setHidden:YES];
        [self.btnCKXQ setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:YES];
        [self.btnQPJ setHidden:YES];
        [self.btnYWC setHidden:YES];
        [self.btnCKWL setHidden:YES];
        [self.btnCKPJ setHidden:YES];
        [self.btnYGB setHidden:YES];
    }//待确认
    else if ([self.order.order_info.order_status isEqualToString:@"3"]) {
        [self.btnQFK setHidden:YES];
        self.ckxqMarginRight.constant=100;
        [self.btnCKXQ setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:NO];
        [self.btnSCDD setHidden:YES];
        [self.btnQPJ setHidden:YES];
        [self.btnYWC setHidden:YES];
        [self.btnCKWL setHidden:YES];
        [self.btnCKPJ setHidden:YES];
        [self.btnYGB setHidden:YES];
    }
    else if ([self.order.order_info.order_status isEqualToString:@"4"]) {
        [self.btnQFK setHidden:YES];
        [self.btnQPJ setTitle:@"去评价" forState:UIControlStateNormal];
        self.ckxqMarginRight.constant=100;
        [self.btnCKXQ setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:YES];
        [self.btnQPJ setHidden:NO];
        [self.btnYWC setHidden:YES];
        [self.btnCKWL setHidden:YES];
        [self.btnCKPJ setHidden:YES];
        [self.btnYGB setHidden:YES];
    }
    else if ([self.order.order_info.order_status isEqualToString:@"5"]) {
        [self.btnQFK setHidden:YES];
        //self.ckxqMarginRight.constant=100;
        [self.btnCKXQ setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:YES];
        [self.btnQPJ setHidden:YES];
        [self.btnYWC setHidden:NO];
        [self.btnCKPJ setHidden:YES];
        [self.btnCKWL setHidden:YES];
        [self.btnYGB setHidden:YES];
    }
    else if ([self.order.order_info.order_status isEqualToString:@"6"]||[self.order.order_info.order_status isEqualToString:@"7"]) {
        [self.btnQFK setHidden:YES];
        [self.btnCKXQ setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:YES];
        [self.btnQPJ setHidden:YES];
        [self.btnYWC setHidden:NO];
        [self.btnCKWL setHidden:YES];
        [self.btnCKPJ setHidden:YES];
        [self.btnYGB setHidden:YES];
    }
    else if ([self.order.order_info.order_status isEqualToString:@"9"]) {
        self.ckxqMarginRight.constant = 100;
        [self.btnQFK setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:YES];
        [self.btnQPJ setHidden:YES];
        [self.btnCKWL setHidden:YES];
        [self.btnCKPJ setHidden:YES];
        [self.btnCKXQ setHidden:YES];
        [self.btnYWC setHidden:YES];
        [self.btnYGB setHidden:NO];
    }
    else if ([self.order.order_info.order_status isEqualToString:@"11"]) {
        self.ckxqMarginRight.constant = 100;
        [self.btnQPJ setTitle:@"申请退款" forState:UIControlStateNormal];
        [self.btnQFK setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:YES];
        [self.btnQPJ setHidden:NO];
        [self.btnCKWL setHidden:YES];
        [self.btnCKPJ setHidden:YES];
        [self.btnCKXQ setHidden:YES];
        [self.btnYWC setHidden:YES];
        [self.btnYGB setHidden:YES];
    }
    else {
        [self.btnQFK setHidden:YES];
        [self.btnCKXQ setHidden:YES];
        [self.btnGBJY setHidden:YES];
        [self.btnQRSH setHidden:YES];
        [self.btnSCDD setHidden:YES];
        [self.btnQPJ setHidden:YES];
        [self.btnYWC setHidden:YES];
        [self.btnCKWL setHidden:YES];
        [self.btnCKPJ setHidden:YES];
        [self.btnYGB setHidden:YES];
    }

}
//确认收货
- (IBAction)btnQRSHTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didQRSHTaped:)])
    {
        [self.delegate didQRSHTaped:self.order];
    }
}
//查看物流
- (IBAction)btnCKWLTapped:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(didCKWLTaped:)])
//    {
//        [self.delegate didCKWLTaped:self.order];
//    }
}
//提醒发货
- (IBAction)btnTXFHTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didCKXQTapped:)])
    {
        [self.delegate didCKXQTapped:self.order];
    }
}
//去付款
- (IBAction)btnQFKTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didQFKTaped:)])
    {
        [self.delegate didQFKTaped:self.order];
    }
}
//删除订单
- (IBAction)btnSCDDTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSCDDTaped:)])
    {
        [self.delegate didSCDDTaped:self.order];
    }
}
//关闭交易订单
- (IBAction)btnGBJYTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didGBJYTaped:)])
    {
        [self.delegate didGBJYTaped:self.order];
    }
}

- (IBAction)btnQPJTapped:(id)sender {
    if ([self.order.order_info.order_status isEqualToString:@"4"]) {
        if ([self.delegate respondsToSelector:@selector(didQPJTaped:)]) {
            [self.delegate didQPJTaped:self.order];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(didSQSHTaped:)]) {
            [self.delegate didSQSHTaped:self.order];
        }
    }
}

- (IBAction)btnCKPJTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didCKPJTaped:)])
    {
        [self.delegate didCKPJTaped:self.order];
    }
}



@end




