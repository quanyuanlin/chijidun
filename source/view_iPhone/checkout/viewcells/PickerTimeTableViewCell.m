//
//  PickerTimeTableViewCell.m
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import "PickerTimeTableViewCell.h"

@implementation PickerTimeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labTitle setFont:[UIFont LightFontOfSize:16]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindWith:(NSString *)time
{
    [self.labTitle setText:time];
}

@end
