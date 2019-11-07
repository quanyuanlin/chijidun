//
//  ScoreViewController.h
//  
//
//  Created by iMac on 16/1/4.
//
//

#import <UIKit/UIKit.h>
#import "ScoreDetailViewController.h"

@interface ScoreViewController : TBaseUIViewController
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

- (IBAction)detailBtnTapped:(id)sender;



@end
