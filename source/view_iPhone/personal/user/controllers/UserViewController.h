#import <UIKit/UIKit.h>
#import "TBaseUIViewController.h"
#import "LoginViewController.h"
#import "CouponController.h"
#import "UserSettingViewController.h"
#import "OrderListViewController.h"
#import "UserBackend.h"
#import "UserEditViewController.h"
#import "CommentDetailVC.h"
#import "MyCommentsViewController.h"
#import "WebHtmlViewController.h"
#import "FavViewController.h"
#import "ScoreViewController.h"
#import "UserAddressListViewController.h"
#import "UserButton.h"

@interface UserViewController : TBaseUIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UserEditViewControllerDelegate>
{
    BOOL ISLoadedUserInfo;
}

/**
 *  各属性请对照.xib文件
 */
//@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (strong, nonatomic) UITableView *mainTableView;

@property (strong, nonatomic) USER *user;
@property (strong, nonatomic) UserBackend *backend;

-(void)loadData;

@end
