//
//  HomeViewController.h
//  chijidun
//
//  Created by iMac on 16/12/5.
//
//

#import <UIKit/UIKit.h>
#import "LocationHelper.h"
#import "SDCycleScrollView.h"
#import "HomeItemCell.h"
#import "ChangeLocationVC.h"
#import "MYTextField.h"
#import "ThrowLineTool.h"
#import "HomeSearchViewController.h"
#import "FindDetailViewController.h"

@interface HomeViewController : TBaseUIViewController
<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UITextFieldDelegate>

@property BOOL isFirst;
@property double latt;
@property double lngg;

@end
