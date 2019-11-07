//
//  CartTableViewCellFooter.m
//  insuny
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "OrderDetailTableViewCellFooter.h"

@implementation OrderDetailTableViewCellFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect cellRect = self.frame;
    CGContextSetFillColorWithColor(context, BG_COLOR.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, cellRect.size.width, cellRect.size.height));
    //[self.freightLabel setHidden:YES];
    //[self.totalFreight setHidden:YES];
    
    [self.labTicket setFont:FONT_DEFAULT12];
    [self.labTicket mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalCount).offset(70);
        make.centerY.equalTo(self.totalCount);
        make.height.equalTo(@25);
        make.width.equalTo(@80);
    }];

}
- (void)bind
{
    @weakify(self)
    [RACObserve(self, shop_item)
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
    self.totalCount.text=[NSString stringWithFormat:@"共%ld件商品",(long)self.shop_item.cart_goods_list.count];
    float totalPrice=0+[self.order.formated_shipping_fee floatValue];
    for (CART_GOODS *cg in self.shop_item.cart_goods_list) {
        totalPrice+=cg.goods_price*cg.goods_number;
    }
    self.totalFreight.text=[NSString stringWithFormat:@"￥%.2f",[self.order.formated_shipping_fee floatValue]];    
    self.totalPrice.text=[NSString stringWithFormat:@"￥%@",self.order.order_info.total_fee];
}


@end
