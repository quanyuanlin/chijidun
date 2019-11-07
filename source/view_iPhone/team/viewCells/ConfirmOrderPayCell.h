//
//  ConfirmOrderPayCell.h
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderPayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDesc;
@property (weak, nonatomic) IBOutlet UILabel *labPay;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
- (IBAction)btnSelectClicked:(id)sender;

-(void)bindWithType:(ConfirmOrderResponse *)response Row:(NSInteger)indexRow;

@end
