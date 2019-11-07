//
//  CheckOutAddressCell.h
//  chijidun
//
//  Created by iMac on 16/10/31.
//
//

#import <UIKit/UIKit.h>

@interface CheckOutAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;
@property (weak, nonatomic) IBOutlet UIImageView *detailIconView;

@property NSString *currentAddress;
-(void)bindWith:(UserAddressTable *)address;


@end
