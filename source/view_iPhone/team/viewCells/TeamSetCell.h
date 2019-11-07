//
//  TeamSetCell.h
//  chijidun
//
//  Created by iMac on 16/9/3.
//
//

#import <UIKit/UIKit.h>

@interface TeamSetCell : UITableViewCell

@property (nonatomic,strong) UILabel *labTitle;
@property (nonatomic,strong) UIImageView *selectView;

-(void)bind;

@end
