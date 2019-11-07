//
//  CheckoutTableViewCellHeader.m
//  chijidun
//
//  Created by iMac on 16/10/31.
//
//

#import "CheckoutTableViewCellHeader.h"

@implementation CheckoutTableViewCellHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labTitle setFont:[UIFont LightFontOfSize:15]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}
-(void)bindWith:(MemberTable *)member
{
    [self.labTitle setText:member.name];
    [self.iconView load:member.img];
}
@end
