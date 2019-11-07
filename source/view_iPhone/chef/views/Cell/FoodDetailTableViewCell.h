//
//  FoodDetailTableViewCell.h
//  chijidun
//
//  Created by iMac on 16/12/6.
//
//

#import <UIKit/UIKit.h>

@interface FoodDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labDesc;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UIButton *buttonCart;
- (IBAction)buttonCartClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *btnBackView;
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;
@property (weak, nonatomic) IBOutlet UILabel *labNum;
@property (weak, nonatomic) IBOutlet UIButton *buttonMinus;

@property (weak, nonatomic) IBOutlet UILabel *buttonSellOut;

- (IBAction)buttonAddClicked:(id)sender;
- (IBAction)buttonMinusClicked:(id)sender;

@property BOOL isTomorrow;
@property(nonatomic,strong)MemberTable *member;
-(void)bindWith:(ItemTable *)item;

@property (strong,nonatomic) void(^cartBlock)(ItemTable *item,BOOL animated);
@property (strong,nonatomic) void(^teamCartBlock)(ChefItemTable *item,BOOL animated);

@property BOOL isTeam;
@property(nonatomic,strong) GetMembersAndOrderResponse *responseData;
@property(weak,nonatomic)ChefTable *chef;
-(void)bindWithTeam:(ChefItemTable *)item;


@end







