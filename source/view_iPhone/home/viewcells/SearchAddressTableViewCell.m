//
//  SearchAddressTableViewCell.m
//  chijidun
//
//  Created by iMac on 16/11/14.
//
//

#import "SearchAddressTableViewCell.h"

@implementation SearchAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labTitle setFont:[UIFont LightFontOfSize:17]];
    [self.labDesc setFont:[UIFont LightFontOfSize:14]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)bindWith:(BMKPoiInfo *)info Index:(NSInteger)index
{
    [self.labDesc setText:info.address];
    if (_table2) {
        self.labTitleConstraints.constant=7;
        self.labDescConstraints.constant=7;
        [self.iconView setImage:[UIImage imageNamed:@"address_black"]];
        [self.labTitle setTextColor:TEXT_DEEP];
        [self.labTitle setText:info.name];
    }else{
        if (index==0) {
            [self.iconView setImage:[UIImage imageNamed:@"address_red"]];
            [self.labTitle setTextColor:RED_COLOR];
            [self.labTitle setText:[NSString stringWithFormat:@"[当前]%@",info.name]];
        }else{
            [self.iconView setImage:[UIImage imageNamed:@"address_black"]];
            [self.labTitle setTextColor:TEXT_DEEP];
            [self.labTitle setText:info.name];
        }
    }
}

@end
