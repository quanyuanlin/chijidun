#import <UIKit/UIKit.h>
#import "CExpandHeader.h"
#import "SDCycleScrollView.h"
#import "LoginViewController.h"
#import "FoodHotCell.h"
#import "ChefStoryView.h"
#import "FoodCartView.h"
#import "CheckOutViewController.h"
#import "ChefDetailVC.h"
#import "ChefWarnView.h"
#import "FoodDetailView.h"
#import "EmptyView.h"

@class MemberTable;
@protocol chefFoodsDelegate <NSObject>

- (void)clickBackButton;

- (void)goCommentViewWith:(NSString *)mid;
- (void)clickWith:(NSString *)date;
-(void)shareChef;
@end

@interface ChefFoodsView : UIView
<UIScrollViewDelegate>
{
    id <chefFoodsDelegate> m_chefFoodsDelegate;
}
@property(nonatomic, strong) id <chefFoodsDelegate> p_chefFoodsDelegate;
@property(nonatomic, strong) ApiClient *apiClient;
@property(nonatomic, strong) CGClient *cgClient;

- (void)reloadDataWith:(MemberTable *)model;

@property(nonatomic, strong) NSString *selectDate;
@property(strong, nonatomic) NSArray *coverItems;
@property(strong, nonatomic) CExpandHeader *header;
@property(strong, nonatomic) USER *user;

@property(nonatomic,strong)NSString *selectId;
-(void)scrollToCell;
-(void)showEmptyView;

@end
