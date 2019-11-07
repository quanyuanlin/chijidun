#import <UIKit/UIKit.h>
#import "ItemTable.h"
#import "CartTable.h"
#import "MemberTable.h"
@class ItemTable;
@class CartTable;
@class MemberTable;

@interface FoodDescCell : UITableViewCell
<CAAnimationDelegate>

@property (strong, nonatomic) USER *user;

@property(weak, nonatomic) IBOutlet UILabel *bookLabel;

@property(weak, nonatomic) IBOutlet UILabel *labNum;
@property(weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property(weak, nonatomic) IBOutlet UILabel *labName;
@property(weak, nonatomic) IBOutlet UILabel *priceLabel;
@property(weak, nonatomic) IBOutlet UIButton *addButton;
@property(weak, nonatomic) IBOutlet UIButton *reduceButton;
@property(weak, nonatomic) IBOutlet UILabel *labRest;
@property (weak, nonatomic) IBOutlet UILabel *labLine;
@property (weak, nonatomic) IBOutlet UILabel *labDesc;

@property(weak,nonatomic)MemberTable *memberTable;
@property(weak,nonatomic)ItemTable *itemTable;

- (IBAction)addFood:(id)sender;

- (IBAction)reduceFood:(id)sender;

- (void)setSubviewWith:(BOOL)isTomorrow;

- (void)cellRefreshDataWith:(ItemTable *)model And:(NSInteger)number;

@property (strong,nonatomic) void(^cartBlock)(ItemTable *item,BOOL animated);


@end






