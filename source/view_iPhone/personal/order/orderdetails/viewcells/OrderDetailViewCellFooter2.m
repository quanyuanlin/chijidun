//
//  OrderDetailViewCellFooter2.m
//  chijidun
//
//  Created by iMac on 15/10/14.
//
//

#import "OrderDetailViewCellFooter2.h"

@implementation OrderDetailViewCellFooter2

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect cellRect = self.frame;
    CGContextSetFillColorWithColor(context, BG_COLOR.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, cellRect.size.width, cellRect.size.height));
    self.labline.backgroundColor=BG_COLOR;
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

    self.freightLabel.text=[NSString stringWithFormat:@"￥%.2f",[self.order.formated_shipping_fee floatValue]];
    self.totalPrice.text=[NSString stringWithFormat:@"￥%@",self.order.order_info.total_fee];
    self.labTicket.text=[NSString stringWithFormat:@"-￥%@", self.order.formated_bonus];
    self.labTruePrice.text=[NSString stringWithFormat:@"￥%@",self.order.order_info.htotal];

}
@end
