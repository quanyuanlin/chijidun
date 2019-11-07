//
//  CartTableViewCellFooter.h
//  insuny
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderListTableViewCellFooter;
@protocol OrderListTableViewCellFooterDelegate <NSObject>

@optional
- (void)didQFKTaped:(ORDER *)anOrder;
//- (void)didCKWLTaped:(ORDER *)anOrder;
- (void)didCKXQTapped:(ORDER *)anOrder;
- (void)didQRSHTaped:(ORDER *)anOrder;
- (void)didSCDDTaped:(ORDER *)anOrder;
- (void)didGBJYTaped:(ORDER *)anOrder;
- (void)didTXSCTaped:(ORDER *)anOrder;
- (void)didQPJTaped:(ORDER *)anOrder;
- (void)didCKPJTaped:(ORDER *)anOrder;
- (void)didSQSHTaped:(ORDER *)anOrder;
-(void)didFKJSTapped:(ORDER *)anOrder;
@end
/**
 *  cell模板，各属性请对照.xib文件
 */
@interface OrderListTableViewCellFooter : TUITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *labTicket;

@property (weak, nonatomic) IBOutlet UILabel *totalCount;
@property (weak, nonatomic) IBOutlet UILabel *totalFreight;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
//@property (weak, nonatomic) IBOutlet UILabel *expressLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnQRSH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ckxqMarginRight;
@property (weak, nonatomic) IBOutlet UIButton *btnCKXQ;
@property (weak, nonatomic) IBOutlet UIButton *btnGBJY;
@property (weak, nonatomic) IBOutlet UIButton *btnQFK;
@property (weak, nonatomic) IBOutlet UIButton *btnSCDD;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scddMarginRight;

@property (strong, nonatomic) id<OrderListTableViewCellFooterDelegate> delegate;
- (IBAction)btnQRSHTapped:(id)sender;
- (IBAction)btnCKXQTapped:(id)sender;
- (IBAction)btnQFKTapped:(id)sender;
- (IBAction)btnSCDDTapped:(id)sender;
- (IBAction)btnGBJYTapped:(id)sender;

@property (strong, nonatomic) ORDER *order;
@property (strong, nonatomic) SHOP_ITEM *shop_item;
@end






