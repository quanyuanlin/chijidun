//
//  HomeSearchViewController.h
//  chijidun
//
//  Created by iMac on 16/12/8.
//
//

#import <UIKit/UIKit.h>
#import "SearchTableViewCellHeader.h"
#import "SearchResultTableViewCell.h"

@interface HomeSearchViewController : TBaseUIViewController
<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property double latt;
@property double lngg;
@property (nonatomic,strong)NSString *city;

@end
