//
//  SearchResultTableViewCell.m
//  chijidun
//
//  Created by iMac on 16/12/7.
//
//

#import "SearchResultTableViewCell.h"

@implementation SearchResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labTitle setFont:[UIFont LightFontOfSize:17]];
    [self.labDesc setFont:[UIFont LightFontOfSize:12]];
    [self.labPrice setFont:[UIFont LightFontOfSize:18]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindWith:(ItemTable *)item
{
    [self.imgView loadImage:item.img placeHolder:img_placehold_small];
    [self.labTitle setText:item.title];
    [self.labDesc setText:item.item_desc];
    [self.labPrice setText:[NSString stringWithFormat:@"￥%@",item.price]];
    
    if (_searchText.length>0) {
        NSRange range = [item.title rangeOfString:_searchText];
        NSUInteger location = range.location;
        NSUInteger length = range.length;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:item.title];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:RED_COLOR
                              range:NSMakeRange(location, length)];
        [self.labTitle setAttributedText:AttributedStr];
    }
    
}

@end
