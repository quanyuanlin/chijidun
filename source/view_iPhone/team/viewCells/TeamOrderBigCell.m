//
//  TeamOrderBigCell.m
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import "TeamOrderBigCell.h"

@implementation TeamOrderBigCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.labType.layer.cornerRadius=10.0f;
    self.labType.layer.masksToBounds=YES;
    
    [self.labType setFont:[UIFont LightFontOfSize:13]];
    [self.labName setFont:[UIFont LightFontOfSize:15]];
    [self.labFood setFont:[UIFont LightFontOfSize:16]];
    [self.labNum setFont:[UIFont LightFontOfSize:15]];
    [self.labMoney setFont:[UIFont LightFontOfSize:18]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindWith:(ChefItemTable *)item
{
    if (self.category.intValue==1) {
        [self.labType setBackgroundColor:getUIColor(0x7ecc1e)];
        [self.labType setText:@"私"];
    }else{
        [self.labType setBackgroundColor:getUIColor(0x0099ff)];
        [self.labType setText:@"厅"];
    }
    [self.labName setText:item.mname];
    [self.labFood setText:item.title];
    [self.labNum setText:[NSString stringWithFormat:@"×%@",item.num]];
    //[self.labMoney setText:[NSString stringWithFormat:@"￥%@",item.price]];
    
    NSString *money=[NSString stringWithFormat:@"￥%@",item.price];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont LightFontOfSize:17]
                          range:NSMakeRange(0, 1)];
    self.labMoney.attributedText = AttributedStr;
}
@end







