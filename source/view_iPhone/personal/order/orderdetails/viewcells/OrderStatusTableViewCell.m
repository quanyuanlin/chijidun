//
//  OrderStatusTableViewCell.m
//  insuny
//
//  Created by iMac on 15/8/21.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "OrderStatusTableViewCell.h"
#define LIGHT_ORANGE  [UIColor colorWithRed:255/255.f green:190/255.f blue:139/255.f alpha:1.000]
@implementation OrderStatusTableViewCell

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect cellRect = self.frame;
    CGContextSetFillColorWithColor(context, WHITE_COLOR.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, cellRect.size.width, cellRect.size.height));
    [self.contentView setBackgroundColor:LIGHT_ORANGE];
}
-(void)setOrderStatus
{
    NSArray *array;
    if ([self.order.order_info.order_status isEqualToString:@"11"]) {
        array=@[@"已支付",@"已拒单",@"申请退款"];
        [self addRefundStatusWith:array];
    }else if ([self.order.order_info.order_status isEqualToString:@"8"]||[self.order.order_info.order_status isEqualToString:@"10"]) {
        array=@[@"待退款",@"退款中",@"已退款"];
        [self addRefundStatusWith:array];
    }else{
        array=@[@"待付款",@"待接单",@"待配送",@"待确认",@"待评价"];
        [self addRefundStatusWith:array];
    }
}
-(void)addRefundStatusWith:(NSArray *)array
{    
    CGFloat imgWidth=20;
    CGFloat labWidth=55;
    
    CGFloat  lineWidth=(kMainScreen_Width-kMainScreen_Width*0.16-imgWidth*array.count)/(array.count-1);
    
    NSString *status=self.order.order_info.order_status;
    NSInteger index=0;
    if ([status isEqualToString:@"0"]) {
        index=0;
    }
    if ([status isEqualToString:@"1"]||[status isEqualToString:@"10"]||[status isEqualToString:@"11"]){
        index=1;
    }
    if ([status isEqualToString:@"2"]||[status isEqualToString:@"8"]) {
        index=2;
    }
    if ([status isEqualToString:@"4"]||[status isEqualToString:@"5"]) {
        index=4;
    }
    if ([status isEqualToString:@"3"]) {
        index=3;
    }
    
    for (int i=0; i<array.count; i++) {
        UIImageView *imageView=[[UIImageView alloc]init];
        CGFloat imgX=(imgWidth+lineWidth)*i+kMainScreen_Width*0.08;
        [imageView setFrame:CGRectMake(imgX, 20, imgWidth, imgWidth)];
        [imageView setImage:[UIImage imageNamed:@"orderstatus_gray"]];
        if (i<=index) {
            [imageView setImage:[UIImage imageNamed:@"orderstatus_orange"]];
        }
        [self.contentView addSubview:imageView];
        
        if (i<array.count-1) {
            UIImageView *imageLine=[[UIImageView alloc]init];
            CGFloat lineX=imgX+imgWidth-1;
            [imageLine setFrame:CGRectMake(lineX, 28, lineWidth+2, 3)];
            [imageLine setImage:[UIImage imageNamed:@"orderline_gray"]];
            if (i<index) {
                [imageLine setImage:[UIImage imageNamed:@"orderline_orange"]];
            }
            [self.contentView addSubview:imageLine];
        }
        
        UILabel *labStatus=[[UILabel alloc]init];
        CGFloat labX=imgX-10;
        [labStatus setFrame:CGRectMake(labX, 45, labWidth, 15)];
        if ([self.order.order_info.order_status isEqualToString:@"11"]) {
            if (i==2) {
                [labStatus setFrame:CGRectMake(labX-7, 45, labWidth, 15)];
            }
        }
        [labStatus setTextColor:WHITE_COLOR];
        [labStatus setFont:[UIFont systemFontOfSize:13]];
        [labStatus setText:array[i]];
        [self.contentView addSubview:labStatus];
        if (i<=index) {
            [labStatus setTextColor:MAIN_COLOR3];
        }
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
