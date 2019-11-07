//
//  UserAddressCompleteTableViewCell.h
//  chijidun
//
//  Created by iMac on 16/11/17.
//
//

#import <UIKit/UIKit.h>
#import "UserAddressListViewController.h"
#import "UserAddressAddViewController.h"

@interface UserAddressCompleteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDesc;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UILabel *labNeedComplete;

- (IBAction)editBtnClicked:(id)sender;

@property BOOL isCheckOut;
-(void)bindWith:(UserAddressTable *)address;

@property (strong,nonatomic) void(^editBlock)();


@end
