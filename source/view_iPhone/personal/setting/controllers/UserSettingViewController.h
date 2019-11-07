#import <UIKit/UIKit.h>
#import "UserBackend.h"
#import "FeedbackViewController.h"
#import "RegisterViewController.h"

/**
 *  其他设置
 */
@interface UserSettingViewController : TBaseUIViewController
        <UITableViewDelegate, UITableViewDataSource, FeedbackViewControllerDelegate> {
    UserBackend *backend;
}

@property(strong, nonatomic) USER *user;

@end
