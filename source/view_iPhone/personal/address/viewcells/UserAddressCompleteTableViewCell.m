//
//  UserAddressCompleteTableViewCell.m
//  chijidun
//
//  Created by iMac on 16/11/17.
//
//

#import "UserAddressCompleteTableViewCell.h"

@interface UserAddressCompleteTableViewCell ()
{
    UserAddressTable *_address;
}
@end
@implementation UserAddressCompleteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labTitle setFont:[UIFont LightFontOfSize:16]];
    [self.labDesc setFont:[UIFont LightFontOfSize:17]];
    [self.labNeedComplete setFont:[UIFont LightFontOfSize:15]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editBtnClicked:(id)sender {
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
    _address=[[UserAddressTable alloc]init];
    _address=address;
    [self.labTitle setText:[NSString stringWithFormat:@"%@ %@",address.name,address.tele]];
    [self.labDesc setText:[NSString stringWithFormat:@"%@%@",address.address,address.house_number]];
    
}

@end
