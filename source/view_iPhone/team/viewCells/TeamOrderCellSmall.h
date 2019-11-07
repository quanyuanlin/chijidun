//
//  TeamOrderCellSmall.h
//  chijidun
//
//  Created by iMac on 16/10/13.
//
//

#import <UIKit/UIKit.h>

@interface TeamOrderCellSmall : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *labdate;
@property (weak, nonatomic) IBOutlet UILabel *labStatus;
@property (weak, nonatomic) IBOutlet UILabel *labFood;
@property (weak, nonatomic) IBOutlet UILabel *labOrderTime;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;

-(void)bindWith:(TeamOrderTable *)order;

@end
