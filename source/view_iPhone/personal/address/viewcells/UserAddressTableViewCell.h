//
//  UserAddressTableViewCell.h
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import <UIKit/UIKit.h>
#import "UserAddressListViewController.h"
#import "UserAddressAddViewController.h"

@interface UserAddressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
- (IBAction)btnEditClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property BOOL isCheckOut;
-(void)bindWith:(UserAddressTable *)address;

@property (strong,nonatomic) void(^editBlock)();


@end
