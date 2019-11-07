//
//  FoodDetailView.h
//  chijidun
//
//  Created by iMac on 16/12/6.
//
//

#import <UIKit/UIKit.h>
#import "FoodDetailDescCell.h"
#import "FoodDetailTableViewCell.h"

@interface FoodDetailView : UIView
<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) ApiClient *apiClient;
@property(nonatomic, strong) CGClient *cgClient;

@property(weak,nonatomic)MemberTable *memberTable;
@property(weak,nonatomic)ItemTable *itemTable;
@property BOOL isTomorrow;

-(void)reloadSubViews;
-(void)loadDetailData;
-(void)reloadData;

@property (strong,nonatomic) void(^cartBlock)(ItemTable *item);
@property (strong,nonatomic) void(^removeBlock)();

@end
