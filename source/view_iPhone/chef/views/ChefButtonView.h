#import <UIKit/UIKit.h>

@protocol chefButtonDelegate <NSObject>

- (void)ClickTodayOrTommorrowWith:(BOOL)isT;

@end

@interface ChefButtonView : UIView {
    id <chefButtonDelegate> m_chefButtonDelegate;
}
@property(nonatomic, strong) id <chefButtonDelegate> p_chefButtonDelegate;
-(void)changeWith:(NSString *)date;

@end
