//
//  CheckOutViewController.h
//  chijidun
//
//  Created by iMac on 16/10/31.
//
//

#import <UIKit/UIKit.h>
#import "PaymentViewController.h"
#import "UserAddressListViewController.h"
#import "CouponController.h"
#import "PickerTimeView.h"
#import "PayResultViewController.h"
#import "QuanTable.h"
#import "ReamrkViewController.h"

#import "CheckOutAddressCell.h"
#import "CheckoutTableViewCellHeader.h"
#import "CheckoutTableViewCell.h"
#import "RemarkTableViewCell.h"
#import "TeamOrderCell.h"

@interface CheckOutViewController : TBaseUIViewController
<UITableViewDelegate,UITableViewDataSource,pickerTimeViewDelegate,RemarkTableViewCellDelegate>

-(instancetype)initWithCart:(BOOL)isTomorrow;
@property(nonatomic,strong)MemberTable *member;
@property(nonatomic,strong)NSString *expressPrice;

@end
