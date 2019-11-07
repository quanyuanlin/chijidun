//
//  CheckoutTableViewCellHeader.h
//  chijidun
//
//  Created by iMac on 16/10/31.
//
//

#import <UIKit/UIKit.h>

@interface CheckoutTableViewCellHeader : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *labTitle;

-(void)bindWith:(MemberTable *)member;


@end
