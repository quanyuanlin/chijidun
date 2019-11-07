//
//  PickerTimeTableViewCell.h
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import <UIKit/UIKit.h>

@interface PickerTimeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

-(void)bindWith:(NSString *)time;


@end
