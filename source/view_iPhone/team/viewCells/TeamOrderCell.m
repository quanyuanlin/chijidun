//
//  TeamOrderCell.m
//  chijidun
//
//  Created by iMac on 16/9/24.
//
//

#import "TeamOrderCell.h"

@interface TeamOrderCell ()
{
    UIView *m_backView;
}
@end
@implementation TeamOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labName setFont:[UIFont LightFontOfSize:16]];
    [self.labNum setFont:[UIFont LightFontOfSize:15]];
    [self.labPrice setFont:[UIFont LightFontOfSize:18]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindWith:(ChefItemTable *)item
{
    [self.labName setText:item.title];
    [self.labNum setText:[NSString stringWithFormat:@"×%@",item.num]];
    //[self.labPrice setText:[NSString stringWithFormat:@"￥%@",item.price]];
    
    NSString *money=[NSString stringWithFormat:@"￥%@",item.price];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont LightFontOfSize:17]
                          range:NSMakeRange(0, 1)];
    self.labPrice.attributedText = AttributedStr;
}
-(void)bindWithCheckOut:(ItemTable *)item
{
    self.labNameRight.constant=kDistanceMin;
    [self.labName setText:item.title];
    [self.labNum setText:[NSString stringWithFormat:@"×%@",item.sum]];
    
    float price=item.sum.intValue*item.price.floatValue;
    int t=(int)price;
    NSString *total=[NSString stringWithFormat:@"%.1f",price];
    if (price==t) {
        total=[NSString stringWithFormat:@"%d",t];
    }
    NSString *money=[NSString stringWithFormat:@"￥%@",total];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont LightFontOfSize:17]
                          range:NSMakeRange(0, 1)];
    self.labPrice.attributedText = AttributedStr;
}
@end








