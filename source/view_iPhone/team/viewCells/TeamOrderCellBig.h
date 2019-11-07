//
//  TeamOrderCellBig.h
//  chijidun
//
//  Created by iMac on 16/10/13.
//
//

#import <UIKit/UIKit.h>

@interface TeamOrderCellBig : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *labdate;
@property (weak, nonatomic) IBOutlet UILabel *labStatus;
@property (weak, nonatomic) IBOutlet UILabel *labFood;
@property (weak, nonatomic) IBOutlet UILabel *labOrderTime;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;

@property (weak, nonatomic) IBOutlet UIButton *btnStatus;
- (IBAction)btnClicked:(id)sender;

-(void)bindWith:(TeamOrderTable *)order;

@property (strong,nonatomic) void(^payBlock)(TeamOrderTable *order);
@property (strong,nonatomic) void(^cancelBlock)(TeamOrderTable *order);
@property (strong,nonatomic) void(^timerEndBlock)();

@end
