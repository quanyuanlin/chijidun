//
//  SearchAddressTableViewCell.h
//  chijidun
//
//  Created by iMac on 16/11/14.
//
//

#import <UIKit/UIKit.h>
#import "BaiduMapHelper.h"

@interface SearchAddressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDesc;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labTitleConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labDescConstraints;

@property BOOL table2;
-(void)bindWith:(BMKPoiInfo *)info Index:(NSInteger)index;


@end
