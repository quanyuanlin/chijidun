//
//  FavViewController.h
//  insuny
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserBackend.h"
#import "ApiClient.h"
#import "QuanTable.h"

@interface CouponController : TBaseUIViewController <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

-(instancetype)initWithCheckOut:(QuanTable *)quan;

@property(nonatomic,retain)UITableView* tableView;
@property (nonatomic, weak) USER *user;

@property (strong,nonatomic) void(^selectBlock)(QuanTable *quan);

@end




