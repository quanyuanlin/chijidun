//
//  CartTableViewCellHeader.m
//  insuny
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "OrderListTableViewCellHeader.h"

@implementation OrderListTableViewCellHeader

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect cellRect = self.frame;
    CGContextSetFillColorWithColor(context, BG_COLOR.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, cellRect.size.width, cellRect.size.height));
    self.statusLabel.textColor=MAIN_COLOR;
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUser:)];
    [self addGestureRecognizer:tapGesture];
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
    self.nameLabel.text=[NSString stringWithFormat:@"%@ %@",self.order.order_info.member_title,toNSString(self.order.order_info.order_id)];
    self.statusLabel.text=self.order.order_info.order_sstatus;
}
-(void)clickUser:(UIGestureRecognizer *)gesture
{
    SEL selector = @selector(ClickOrderListTableViewCellHeader:);
    if ([self.delegate respondsToSelector:selector]) {
        [self.delegate ClickOrderListTableViewCellHeader:self.order];
    }
}
@end


