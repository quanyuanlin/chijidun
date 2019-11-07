//
//  FavTableViewCell.h
//  btc
//
//  Created by txj on 15/3/27.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QuanTable.h"
@class QuanTable;
@interface CouponTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopname;
@property (weak, nonatomic) IBOutlet UILabel *subtitle1;
@property (weak, nonatomic) IBOutlet UILabel *subtitle2;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *labStatus;
@property (weak, nonatomic) IBOutlet UIImageView *selectTicketView;

@property(nonatomic,strong)QuanTable *quanTable;
@property(nonatomic,strong)NSString * couponid;

-(void)bindWith:(QuanTable *)quan;

@end
