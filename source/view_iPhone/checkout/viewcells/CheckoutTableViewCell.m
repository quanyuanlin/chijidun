//
//  CartTableViewCell.m
//  btc
//
//  Created by txj on 15/3/28.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "CheckoutTableViewCell.h"

@implementation CheckoutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

-(void)bindWith:(ItemTable *)item
{
    self.titleLabel.text = item.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",
                            item.price];
    
    self.quantityLabel.text=[NSString stringWithFormat:@"x%@",item.sum];
    [self.coverImage loadImage:item.img placeHolder:img_placehold_small];
}
@end




