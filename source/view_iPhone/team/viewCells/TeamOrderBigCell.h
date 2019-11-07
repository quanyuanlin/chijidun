//
//  TeamOrderBigCell.h
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import <UIKit/UIKit.h>

@interface TeamOrderBigCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labType;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labFood;
@property (weak, nonatomic) IBOutlet UILabel *labNum;
@property (weak, nonatomic) IBOutlet UILabel *labMoney;

@property(nonatomic,strong)NSString *category;
-(void)bindWith:(ChefItemTable *)item;

@end
