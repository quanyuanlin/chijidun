//
//  UserAddressListViewController.h
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import <UIKit/UIKit.h>
#import "UserAddressTableViewCell.h"
#import "UserAddressCompleteTableViewCell.h"
#import "UserAddressAddViewController.h"

@interface UserAddressListViewController : TBaseUIViewController
<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)MemberTable *member;
@property (strong,nonatomic) void(^selectBlock)(UserAddressTable *address);


-(id)initWithAddress:(UserAddressTable *)address;

@end
