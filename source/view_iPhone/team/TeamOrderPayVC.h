//
//  TeamOrderPayVC.h
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import <UIKit/UIKit.h>
#import "TeamPaymentCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "TeamOrderPayResultVC.h"
#import "CharacterPayView.h"
#import "TeamOrderDetailViewController.h"

@interface TeamOrderPayVC : TBaseUIViewController
<UITableViewDelegate,UITableViewDataSource,WXApiDelegate>

@property(nonatomic,strong)TeamOrderTable *order;
@property(nonatomic,strong)NSString *orderId;

@property BOOL goLastVC;
@property BOOL goFirstVC;

@end
