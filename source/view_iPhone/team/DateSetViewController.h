//
//  DateSetViewController.h
//  chijidun
//
//  Created by iMac on 16/8/31.
//
//

#import <UIKit/UIKit.h>
#import "TeamSetCell.h"
@interface DateSetViewController : TBaseUIViewController
<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) SwitchTable *switchTable;


@property (nonatomic,strong) void(^switchBlock)(SwitchTable *switchTable);


@end
