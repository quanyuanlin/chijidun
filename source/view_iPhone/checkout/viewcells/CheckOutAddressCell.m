//
//  CheckOutAddressCell.m
//  chijidun
//
//  Created by iMac on 16/10/31.
//
//

#import "CheckOutAddressCell.h"

@implementation CheckOutAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.labName setFont:[UIFont LightFontOfSize:18]];
    [self.labAddress setFont:[UIFont LightFontOfSize:15]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

-(void)bindWith:(UserAddressTable *)address
{
    if (address) {
        [self.iconImage setImage:[UIImage imageNamed:@"address_checkred"]];
        [self.labAddress setTextColor:TEXT_MIDDLE];
        [self.labName setText:[NSString stringWithFormat:@"%@ %@",address.name,address.tele]];
        self.labAddress.text = [NSString stringWithFormat:@"%@%@", address.address, address.house_number];
        
    }else{
        [self.iconImage setImage:[UIImage imageNamed:@"address_black"]];
        [self.labAddress setTextColor:TEXT_LIGHT];
        [self.labName setText:_currentAddress];
        [self.labAddress setText:@"选择配送地址"];
    }
}


@end
