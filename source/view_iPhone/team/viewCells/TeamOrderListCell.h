//
//  TeamOrderListCell.h
//  chijidun
//
//  Created by iMac on 16/9/21.
//
//

#import <UIKit/UIKit.h>

@interface TeamOrderListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backView;

@property(weak,nonatomic) IBOutlet UILabel *labWeek;
@property(weak,nonatomic) IBOutlet UILabel *labDate;
@property(weak,nonatomic) IBOutlet UILabel *labMeal;
@property(weak,nonatomic) IBOutlet UILabel *labTime;
@property(weak,nonatomic) IBOutlet UILabel *labChef;
@property(weak,nonatomic) IBOutlet UILabel *labStatus;
@property(weak,nonatomic) IBOutlet UILabel *labType;
@property(weak,nonatomic) IBOutlet UILabel *labFood;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labDateConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labTimeConstraint;


-(void)bindWith:(OrderIndexTable *)item;

@end
