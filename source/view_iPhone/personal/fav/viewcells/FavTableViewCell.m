//
//  FavTableViewCell.m
//  btc
//
//  Created by txj on 15/3/27.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "FavTableViewCell.h"

@implementation FavTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLabel.textColor=TEXT_COLOR_BLACK;
    self.subtitle1.textColor=TEXT_COLOR_DARK;
    self.subtitle2.textColor=TEXT_COLOR_DARK;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
- (void)bindWith:(MemberFavTable *)fav
{
    [self.coverImage load:fav.member.img];
    self.subtitle1.text=[NSString stringWithFormat:@"菜系：%@",fav.member.caixi];
    self.subtitle2.text=[NSString stringWithFormat:@"地址：%@",fav.member.address];
    self.titleLabel.text=fav.member.title;
    [self.titleLabel alignTop];
}


@end
