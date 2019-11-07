//
//  TeamUnjoinView.h
//  chijidun
//
//  Created by iMac on 16/9/21.
//
//

#import <UIKit/UIKit.h>
#import "TeamOrderListVC.h"
#import "LoginViewController.h"
#import "OpenTeamViewController.h"
#import "JoinTeamViewController.h"

@interface TeamUnjoinView : UIView

@property(nonatomic,strong) HasCompanyResponse *hasCompany;
-(void)reloadViews;

@end
