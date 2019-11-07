#import <UIKit/UIKit.h>
#import "Share.h"
#import "MemberTable.h"
#import "CheckOutViewController.h"
@protocol chefDetailDelegate <NSObject>

- (void)clickBackButton;

@end
@interface ChefDetailVC : TBaseUIViewController
<ISSViewDelegate,ISSShareViewDelegate>
@property (nonatomic,strong) id<chefDetailDelegate> delegate;
@property BOOL isTomorrow;
@property(nonatomic, strong) NSString *Id;
@property double latt;
@property double lngg;

@property BOOL isFaverVC;

@property(nonatomic,strong)NSString *selectItemId;

@end
