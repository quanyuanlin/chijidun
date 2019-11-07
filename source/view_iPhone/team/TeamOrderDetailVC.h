//
//  TeamOrderDetailVC.h
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import <UIKit/UIKit.h>
#import "TeamSetViewController.h"
#import "TeamWeekView.h"
#import "FoodTypeButton.h"
#import "TeamCartView.h"
#import "ChefItemCell.h"
#import "TeamOrderCell.h"
#import "TeamOrderDetailViewController.h"
#import "ThrowLineTool.h"
#import "ConfirmOrderVC.h"
#import "TeamFoodDetailView.h"

@interface TeamOrderDetailVC : TBaseUIViewController
<UITableViewDelegate,UITableViewDataSource>

//抛物线红点
@property(nonatomic,strong) OrderIndexTable *index;

@end
