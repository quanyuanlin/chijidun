//
//  FoodCartView.h
//  吃几顿
//
//  Created by iMac on 15/8/11.
//  Copyright (c) 2015年 杭州赚宝科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamCartCell.h"                                                                                                                                                                                                                               
#import "ItemTable.h"

@interface FoodCartView : UIView
<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *cartList;

@property (strong,nonatomic) void(^deleteBlock)();
@property (strong,nonatomic) void(^removeBlock)();
@property (strong,nonatomic) void(^changeBlock)(ItemTable *item);

@property(nonatomic,strong)UIButton *btnCart;
-(void)reloadCartTable:(BOOL)animated;


@end
