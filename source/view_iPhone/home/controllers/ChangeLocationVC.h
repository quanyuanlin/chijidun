#import <UIKit/UIKit.h>
#import "MYTextField.h"
#import "BaiduMapHelper.h"
#import "modes.h"
#import "SearchAddressCellHeader.h"
#import "UserAddressTableViewCell.h"
#import "UserAddressAddViewController.h"
#import "SearchAddressTableViewCell.h"

@interface ChangeLocationVC : TBaseUIViewController
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong,nonatomic) void(^selectBlock)(double lat,double lng,NSString *address,BOOL isCurrent);

@property double latt;
@property double lngg;

@end
