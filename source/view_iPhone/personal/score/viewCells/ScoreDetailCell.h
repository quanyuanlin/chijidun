//
//  ScoreDetailCell.h
//  
//
//  Created by iMac on 16/1/7.
//
//

#import <UIKit/UIKit.h>

@interface ScoreDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labScore;

-(void)bindWith:(Score_listData *)scoreTable;

@end
