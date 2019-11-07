//
//  HomeItemCell.h
//  chijidun
//
//  Created by iMac on 16/12/1.
//
//

#import <UIKit/UIKit.h>
#import "HomeDescView.h"
#import "TAPageControl.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeItemCell : UITableViewCell
<UIScrollViewDelegate>

@property(nonatomic,strong)TAPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *back2View;

@property (weak, nonatomic) IBOutlet UIScrollView *itemScrollView;
@property (weak, nonatomic) IBOutlet UILabel *labStatus;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *labTown;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;


-(void)bindWith:(MemberTable *)member;
@property (strong,nonatomic) void(^clickBlock)(MemberTable *member,NSString *itemId);

@end
