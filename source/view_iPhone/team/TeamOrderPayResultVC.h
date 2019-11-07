//
//  TeamOrderPayResultVC.h
//  chijidun
//
//  Created by iMac on 16/10/8.
//
//

#import <UIKit/UIKit.h>
#import "TeamOrderDetailViewController.h"

@interface TeamOrderPayResultVC : UIViewController

- (instancetype)initWithOrder:(TeamOrderTable *)anOrder;

@property(strong, nonatomic) TeamOrderTable *order;
@property BOOL isSuccess;



@end
