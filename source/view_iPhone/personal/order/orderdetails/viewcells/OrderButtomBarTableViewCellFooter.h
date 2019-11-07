//
//  CartTableViewCellFooter.h
//  insuny
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListTableViewCellFooter.h"
/**
 *  cell模板，各属性请对照.xib文件
 */
@interface OrderButtomBarTableViewCellFooter : TUITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIButton *btnQRSH;
@property (weak, nonatomic) IBOutlet UIButton *btnCKWL;
@property (weak, nonatomic) IBOutlet UIButton *btnCKXQ;
@property (weak, nonatomic) IBOutlet UIButton *btnQFK;
@property (weak, nonatomic) IBOutlet UIButton *btnSCDD;
@property (weak, nonatomic) IBOutlet UIButton *btnGBJY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ckxqMarginRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gbjyMarginRight;
@property (weak, nonatomic) IBOutlet UIButton *btnQPJ;
@property (weak, nonatomic) IBOutlet UIButton *btnYWC;
@property (weak, nonatomic) IBOutlet UIButton *btnCKPJ;
@property (weak, nonatomic) IBOutlet UIButton *btnYGB;



- (IBAction)btnQRSHTapped:(id)sender;
- (IBAction)btnCKWLTapped:(id)sender;
//- (IBAction)btnCKXQTapped:(id)sender;
- (IBAction)btnQFKTapped:(id)sender;
- (IBAction)btnSCDDTapped:(id)sender;
- (IBAction)btnGBJYTapped:(id)sender;
- (IBAction)btnQPJTapped:(id)sender;
- (IBAction)btnCKPJTapped:(id)sender;

@property (strong, nonatomic) id<OrderListTableViewCellFooterDelegate> delegate;
@property (strong, nonatomic) ORDER *order;

@end
