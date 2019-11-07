//
//  TeamWeekView.h
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import <UIKit/UIKit.h>
#import "DateButton.h"

@interface TeamWeekView : UIView
<UIGestureRecognizerDelegate,CAAnimationDelegate>

@property BOOL hasLeft;
@property BOOL hasRight;
@property(nonatomic,strong)NSArray *lists;
@property(nonatomic,strong)NSString *date;

-(void)addMainView;
-(void)reloadDatasWith:(OrderTimeIntervalTable *)item;

@property (nonatomic,strong) void(^indexBlock)(OrderTimeIntervalTable *item);

@property (nonatomic,strong) void(^swipeBlock)(BOOL isRight);

@property int currentPage;

@end
