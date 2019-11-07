//
//  SearchTableViewCellHeader.h
//  chijidun
//
//  Created by iMac on 16/12/7.
//
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCellHeader : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *labSales;


-(void)bindWith:(MemberTable *)member;

@end
