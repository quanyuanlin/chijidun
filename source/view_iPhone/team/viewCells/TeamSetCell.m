//
//  TeamSetCell.m
//  chijidun
//
//  Created by iMac on 16/9/3.
//
//

#import "TeamSetCell.h"

@implementation TeamSetCell

-(void)bind
{
    if (self.labTitle==nil) {
        self.labTitle=[[UILabel alloc]initWithFrame:CGRectMake(kDistance, 0, kMainScreen_Width*0.5, kCart_HEIGHT)];
    }
    [self.contentView addSubview:self.labTitle];
    
    if (self.selectView==nil) {
        self.selectView=[[UIImageView alloc]initWithFrame:CGRectMake(kMainScreen_Width-kDistance-18, 16, 18, 18)];
        [self.selectView setImage:[UIImage imageNamed:@"team_select"]];
    }
    [self.contentView addSubview:self.selectView];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
