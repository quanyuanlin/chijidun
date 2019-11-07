//
//  AddressView.h
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import <UIKit/UIKit.h>
#import "TeamAddressCell.h"

@interface AddressView : UIView
<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) void(^clickBlock)(TeamAddressTable *addr);

@property(nonatomic,strong)NSArray *arrList;
@property(nonatomic,strong)NSString *selectId;
-(void)reloadDatas;

@end
