//
//  OrderDetailSection3TableViewCell.m
//  insuny
//
//  Created by txj on 15/5/19.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "OrderDetailSection4TableViewCell.h"

@implementation OrderDetailSection4TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.orderidLabel.textColor = TEXT_COLOR_DARK;
    self.paysnLabel.textColor = TEXT_COLOR_DARK;
    self.orderTimeLabel.textColor = TEXT_COLOR_DARK;
    self.payTimeLabel.textColor = TEXT_COLOR_DARK;
    self.checkTimeLabel.textColor = TEXT_COLOR_DARK;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    self.orderidLabel.text = [NSString stringWithFormat:@"订单编号：%@", toNSString(self.order.order_info.order_id)];
    self.paysnLabel.text = [NSString stringWithFormat:@"支付交易号：%@", self.order.order_info.pay_code];
    self.orderTimeLabel.text = [NSString stringWithFormat:@"成交时间：%@", self.order.order_info.order_time];
    self.payTimeLabel.text = [NSString stringWithFormat:@"付款时间：%@", self.order.order_info.pay_time.length == 0 ? @"未付款" : self.order.order_info.pay_time];
    self.checkTimeLabel.text = [NSString stringWithFormat:@"确认时间：%@", self.order.order_info.check_time.length == 0 ? @"-" : self.order.order_info.check_time];
}
@end
