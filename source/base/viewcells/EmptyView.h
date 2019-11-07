//
//  EmptyView.h
//  
//
//  Created by iMac on 15/12/11.
//
//

#import <UIKit/UIKit.h>

@interface EmptyView : UIView

-(void)setImage:(NSString *)img Title:(NSString *)title SubTitle:(NSString *)subTitle;

-(void)setEmptyWith:(NSString *)img Title:(NSString *)title SubTitle:(NSString *)subTitle;


-(void)setImage:(NSString *)img Title:(NSString *)title;

-(void)setBtnWith:(NSString *)title;
@property (strong,nonatomic) void(^clickBtnBlock)();

@end
