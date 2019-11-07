//
//  FavTableViewCell.m
//  btc
//
//  Created by txj on 15/3/27.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)bindWith:(QuanTable *)quan
{
    self.quanTable=quan;
    //self.selectTicketView.hidden=YES;
    
    [self setBackgroundColor:getColorWithRGB(242, 242, 242)];
    
    self.shopname.text=[NSString stringWithFormat:@"￥%@",self.quanTable.price];
    self.subtitle1.text=@"无门槛,全场通用";
    self.subtitle2.text=[NSString stringWithFormat:@"有效期:%@至%@",self.quanTable.stime,self.quanTable.etime];
    self.titleLabel.text=self.quanTable.title;
    
    if ([self.quanTable.used_status isEqualToString:@"0"]) {
        if ([self.quanTable.status isEqualToString:@"5"]){
            [self.labStatus setText:@"已过期"];
            [self.shopname setTextColor:COLOR_MID_GRAY];
            [self.backImageView setImage:[UIImage imageNamed:@"ticketbackgray"]];
        }else{
            [self.labStatus setText:@"未使用"];
            [self.shopname setTextColor:MAIN_COLOR];
            [self.backImageView setImage:[UIImage imageNamed:@"ticketback"]];
        }
    }else{
        [self.labStatus setText:@"已使用"];
        [self.shopname setTextColor:COLOR_MID_GRAY];
        [self.backImageView setImage:[UIImage imageNamed:@"ticketbackgray"]];
    }
    
}

@end








