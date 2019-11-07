#import <UIKit/UIKit.h>
#import <XZFramework/XZImageCropperViewController.h>
#import <XZFramework/TAreaPickerView.h>
#import "UserBackend.h"
/**
 *  用户编辑
 */
@class UserEditViewController;
@protocol UserEditViewControllerDelegate <NSObject>
@optional
-(void)loginOutTapped:(UserEditViewController *)controller;

-(void)userDidChangeData;
@end

@interface UserEditViewController : TBaseUIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, XZImageCropperDelegate,UIActionSheetDelegate>
{
    UIDatePicker *oneDatePicker;
    UIToolbar *toolBar;
    UISegmentedControl *segmentedControl;
    UIImageView *imgviewSFZZM;
    UIImageView *imgviewSFZBM;
    BOOL iscardbg;
    TAreaPickerView  *locatePicker;
    UIImageView *userImage;
}

@property (nonatomic) id<UserEditViewControllerDelegate> delegate;

@property (strong, nonatomic) UILabel *lbArea;
@property (strong, nonatomic) UITextField *tfName;
@property (strong, nonatomic) UITextField *tfEmail;
@property (strong, nonatomic) UITextField *tfSex;
@property (strong, nonatomic) UITextField *tfBirthday;
@property (strong, nonatomic) UITextField *tfDesc;
@property (strong, nonatomic) UITextField *tfTell;
@property (strong, nonatomic) UITextField *tfSFZ;
@property (strong, nonatomic) UIButton *btnSFZZM;
@property (strong, nonatomic) UIButton *btnSFZBM;
@property (strong, nonatomic) USER *user;
@property (strong, nonatomic) UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (strong, nonatomic) UserBackend *backend;
@property(nonatomic,strong)NSString *userImg;

@end

