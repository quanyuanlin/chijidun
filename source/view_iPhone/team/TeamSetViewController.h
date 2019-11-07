//
//  TeamSetViewController.h
//  chijidun
//
//  Created by iMac on 16/8/31.
//
//

#import <UIKit/UIKit.h>
#import "DateSetViewController.h"

@interface TeamSetViewController : TBaseUIViewController
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) void(^backBlock)();

@end
