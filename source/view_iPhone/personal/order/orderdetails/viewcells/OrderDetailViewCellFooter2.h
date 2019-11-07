//
//  OrderDetailViewCellFooter2.h
//  chijidun
//
//  Created by iMac on 15/10/14.
//
//

#import <UIKit/UIKit.h>

@interface OrderDetailViewCellFooter2 : TUITableViewHeaderFooterView


@property (weak, nonatomic) IBOutlet UILabel *labline;

@property (weak, nonatomic) IBOutlet UILabel *labTicket;
@property (weak, nonatomic) IBOutlet UILabel *totalCount;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *freightLabel;
@property (strong, nonatomic) ORDER *order;
@property (strong, nonatomic) SHOP_ITEM *shop_item;
@property (weak, nonatomic) IBOutlet UILabel *labTruePrice;

@end
