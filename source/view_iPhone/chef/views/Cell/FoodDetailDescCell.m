//
//  FoodDetailDescCell.m
//  chijidun
//
//  Created by iMac on 16/12/5.
//
//

#import "FoodDetailDescCell.h"

@implementation FoodDetailDescCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labTitle setFont:[UIFont LightFontOfSize:17]];
    [self.labDesc setFont:[UIFont LightFontOfSize:15]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
