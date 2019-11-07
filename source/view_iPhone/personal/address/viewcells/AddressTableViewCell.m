//
//  AddressTableViewCell.m
//  insuny
//
//  Created by txj on 15/5/15.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.addressLabel.textColor=TEXT_COLOR_DARK;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)bind
{
    self.consigneeLabel.text=self.address.consignee;
    self.teleLabel.text=self.address.tel;
    self.addressLabel.text=[NSString stringWithFormat:@"%@%@%@%@",self.address.province_name,self.address.city_name,self.address.district_name,self.address.address];
    [self.addressLabel alignTop];
}
@end






