//
//  TeamFoodDetailView.h
//  chijidun
//
//  Created by iMac on 16/12/8.
//
//

#import <UIKit/UIKit.h>
#import "FoodDetailDescCell.h"
#import "FoodDetailTableViewCell.h"
#import "ThrowLineTool.h"

@interface TeamFoodDetailView : UIView
<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) CGClient *cgClient;

@property(nonatomic,strong) GetMembersAndOrderResponse *responseData;
@property(weak,nonatomic)ChefTable *chef;
@property(weak,nonatomic)ChefItemTable *itemTable;

-(void)loadDetailData;
-(void)reloadData;

@property (strong,nonatomic) void(^cartBlock)(ChefItemTable *item);
@property (strong,nonatomic) void(^removeBlock)();
@property (nonatomic,strong) UIButton *buttonCart;

@end
