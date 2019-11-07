//
//  TeamOrderCell.h
//  chijidun
//
//  Created by iMac on 16/9/24.
//
//

#import <UIKit/UIKit.h>

@interface TeamOrderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labNum;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;

-(void)bindWith:(ChefItemTable *)item;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labNameRight;

-(void)bindWithCheckOut:(ItemTable *)item;

@end
