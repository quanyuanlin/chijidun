//
//  ConfirmOrderVC.h
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import "TBaseUIViewController.h"
#import "ConfirmOrderPayCell.h"
#import "TeamOrderCell.h"
#import "TeamOrderBigCell.h"
#import "AddressView.h"
#import "TeamOrderPayVC.h"
#import "TeamOrderDetailViewController.h"

@interface ConfirmOrderVC : TBaseUIViewController
<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSString *mealType;
@property(nonatomic,strong)NSString *date;

@property(nonatomic,strong)ConfirmOrderResponse *responseData;

@property (nonatomic,strong) void(^backBlock)(BOOL back);

@end
