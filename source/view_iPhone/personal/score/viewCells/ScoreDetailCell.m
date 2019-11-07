//
//  ScoreDetailCell.m
//  
//
//  Created by iMac on 16/1/7.
//
//

#import "ScoreDetailCell.h"

@implementation ScoreDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //[self.labTitle setTextColor:COLOR_DEEP_GRAY];
    [self.labTime setTextColor:COLOR_MID_GRAY];
    [self.labScore setTextColor:MAIN_COLOR];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)bindWith:(Score_listData *)scoreTable{
    [self.labTitle setText:scoreTable.title];
    [self.labTime setText:scoreTable.add_time];
    [self.labScore setText:[NSString stringWithFormat:@"+%@",scoreTable.score]];
}

@end
