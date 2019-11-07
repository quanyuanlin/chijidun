//
//  FoodHotCell.h
//  
//
//  Created by iMac on 16/1/5.
//
//

#import <UIKit/UIKit.h>
#import "ItemTable.h"
#import "MemberTable.h"
#import "CartTable.h"
@class ItemTable;
@class MemberTable;
@class CartTable;

//@protocol HotFoodCellDelegate <NSObject>
//
//- (void)foodDidChangeWith:(ItemTable *)cart;
//
//@end

@interface FoodHotCell : UITableViewCell
<CAAnimationDelegate>
@property (strong, nonatomic) USER *user;

//@property(nonatomic, strong) id <HotFoodCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labDesc;

@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UIButton *buttonMinus;
@property (weak, nonatomic) IBOutlet UILabel *labRest;
@property (weak, nonatomic) IBOutlet UILabel *labNum;
- (IBAction)buttonAddTapped:(id)sender;
- (IBAction)buttonMinusTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *hotView;
@property (weak, nonatomic) IBOutlet UILabel *labPrecent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hotViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labHotWidth;


@property(weak,nonatomic)MemberTable *memberTable;
@property(weak,nonatomic)ItemTable *itemTable;

-(void)bindWith:(ItemTable *)item;

@property (strong,nonatomic) void(^cartBlock)(ItemTable *item,BOOL animated);


@end
