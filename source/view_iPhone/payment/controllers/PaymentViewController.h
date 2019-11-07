#import <UIKit/UIKit.h>
#import "PaymentBackend.h"
#import "TeamPaymentCell.h"
#import "WXApi.h"
#import "OrderDetailViewController.h"

@interface PaymentViewController : TBaseUIViewController <UITableViewDataSource, UITableViewDelegate, WXApiDelegate, UIAlertViewDelegate>

- (instancetype)initWithOrder:(ORDER *)anOrder;

@property BOOL isCheckOut;
@property(strong, nonatomic) OrderTable *order;
- (instancetype)initWithOrderTable:(OrderTable *)order;


@end
