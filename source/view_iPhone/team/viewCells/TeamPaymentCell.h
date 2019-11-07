//
//  TeamPaymentCell.h
//  chijidun
//
//  Created by iMac on 16/9/28.
//
//

#import <UIKit/UIKit.h>

@interface TeamPaymentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDesc;
@property (weak, nonatomic) IBOutlet UIImageView *selectView;

-(void)bindWith:(NSDictionary *)data;

@end
