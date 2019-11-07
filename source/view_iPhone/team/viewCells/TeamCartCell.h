//
//  TeamCartCell.h
//  chijidun
//
//  Created by iMac on 16/9/23.
//
//

#import <UIKit/UIKit.h>

@interface TeamCartCell : UITableViewCell

@property(nonatomic,strong)NSArray *carts;
@property(nonatomic,strong) GetMembersAndOrderResponse *responseData;

@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnSub;
@property (weak, nonatomic) IBOutlet UILabel *labNum;

- (IBAction)btnAddClicked:(id)sender;
- (IBAction)btnSubClicked:(id)sender;
-(void)bindWith:(ChefItemTable *)item;
@property (copy, nonatomic) void (^numBlock)(ChefItemTable *item,int count);

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labPriceWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labPriceLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labNameTopConstraint;




@property BOOL isPersonnal;
@property (copy, nonatomic) void (^changeBlock)(ItemTable *item,int count);
-(void)bindItemWith:(ItemTable *)item;

@end






