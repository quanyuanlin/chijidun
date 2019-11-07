//
//  UserAddressTableViewCell.m
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import "UserAddressTableViewCell.h"

@interface UserAddressTableViewCell ()
{
    UserAddressTable *_address;
}
@end
@implementation UserAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labTitle setFont:[UIFont LightFontOfSize:16]];
    [self.labDesc setFont:[UIFont LightFontOfSize:17]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnEditClicked:(id)sender {
    UserAddressListViewController *listVC = (UserAddressListViewController *) self.nextResponder.nextResponder.nextResponder.nextResponder;
    UserAddressAddViewController *detail=[[UserAddressAddViewController alloc]initWithAddress:_address Edit:YES];
    detail.successBlock=^{
        if (self.editBlock) {
            self.editBlock();
        }
    };
    [listVC.navigationController pushViewController:detail animated:YES];
}

-(void)bindWith:(UserAddressTable *)address
{
    if (_isCheckOut) {
        if (address.selectable.intValue==1) {
            [self.labTitle setTextColor:TEXT_MIDDLE];
            [self.labDesc setTextColor:TEXT_MIDDLE];
        }else{
            [self.labTitle setTextColor:DISABLE_COLOR];
            [self.labDesc setTextColor:DISABLE_COLOR];
        }
    }
    _address=[[UserAddressTable alloc]init];
    _address=address;
    [self.labTitle setText:[NSString stringWithFormat:@"%@ %@",address.name,address.tele]];
    [self.labDesc setText:[NSString stringWithFormat:@"%@%@",address.address,address.house_number]];
    //[self.iconView setHidden:YES];
    
}

@end
