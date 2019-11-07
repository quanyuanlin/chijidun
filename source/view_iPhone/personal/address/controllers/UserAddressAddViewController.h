//
//  UserAddressAddViewController.h
//  chijidun
//
//  Created by iMac on 16/11/17.
//
//

#import <UIKit/UIKit.h>
#import "SelectAddressViewController.h"
#import "UIApplication+Extend.h"

@interface UserAddressAddViewController : TBaseUIViewController
<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,BMKGeoCodeSearchDelegate>


@property (strong,nonatomic) void(^successBlock)();

-(id)initWithAddress:(UserAddressTable *)address Edit:(BOOL)isEdit;


@end
