//
//  TeamCartView.h
//  chijidun
//
//  Created by iMac on 16/9/23.
//
//

#import <UIKit/UIKit.h>
#import "TeamCartCell.h"

@interface TeamCartView : UIView
<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) GetMembersAndOrderResponse *responseData;

@property(nonatomic,strong)NSMutableArray *cartList;
@property (strong,nonatomic) void(^removeBlock)(NSArray *array);
@property (strong,nonatomic) void(^changeBlock)(NSString *total,NSArray *array);

@property(nonatomic,strong)UIButton *btnCart;

-(void)reloadCartTable;

@end
