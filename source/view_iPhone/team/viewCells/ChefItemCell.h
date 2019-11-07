//
//  ChefItemCell.h
//  chijidun
//
//  Created by iMac on 16/9/23.
//
//

#import <UIKit/UIKit.h>

@interface ChefItemCell : UITableViewCell

@property(nonatomic,strong)NSArray *carts;
@property(nonatomic,strong) GetMembersAndOrderResponse *responseData;
@property(nonatomic,strong)NSString *leftTilte;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *btnSub;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labDots;

- (IBAction)btnSubClicked:(id)sender;
- (IBAction)btnAddClicked:(id)sender;

@property(nonatomic,strong) ChefTable *chef;
-(void)bindWith:(ChefItemTable *)item;


@property (copy, nonatomic) void (^plusBlock)(ChefItemTable *item,int count,BOOL animated);
@property (copy, nonatomic) void (^showDetailBlock)(ChefItemTable *item);


@end
