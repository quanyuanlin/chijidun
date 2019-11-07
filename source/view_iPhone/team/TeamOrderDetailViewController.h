//
//  TeamOrderDetailViewController.h
//  chijidun
//
//  Created by iMac on 16/9/26.
//
//

#import "TBaseUIViewController.h"
#import "TeamOrderCell.h"
#import "TeamOrderBigCell.h"
#import "TeamOrderPayVC.h"

@interface TeamOrderDetailViewController : TBaseUIViewController
<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSString *orderId;

@property BOOL goLastVC;

@end
