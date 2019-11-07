//
//  PayResultViewController.h
//  chijidun
//
//  Created by iMac on 16/11/18.
//
//

#import <UIKit/UIKit.h>
#import "OrderDetailViewController.h"
#import "OrderListViewController.h"

@interface PayResultViewController : TBaseUIViewController

@property(strong, nonatomic) OrderTable *order;
- (instancetype)initWithOrderTable:(OrderTable *)order;
@property BOOL isSuccess;
@property BOOL isCheckOut;

@end
