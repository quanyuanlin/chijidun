//
//  TeamAddressCell.m
//  chijidun
//
//  Created by iMac on 16/10/20.
//
//

#import "TeamAddressCell.h"

@implementation TeamAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labTitle setFont:[UIFont LightFontOfSize:16]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
