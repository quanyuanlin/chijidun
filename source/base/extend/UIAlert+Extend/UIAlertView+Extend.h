//
//  UIAlertView+Extend.h
//  
//
//  Created by iMac on 15/12/14.
//
//

#import <UIKit/UIKit.h>

typedef void (^AlertCompletionBlock)(NSInteger index);
typedef void(^AlertCancelBlock)(void);

@interface UIAlertView_Extend : UIAlertView

@property(nonatomic,copy) AlertCompletionBlock completionBlock;
@property(nonatomic,copy) AlertCancelBlock cancelBlock;

+ (void)showAlertWithTiTle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *) cancelButtonTitle otherButtonTitles:(NSArray *)buttonTitles withCompletionBlock:(AlertCompletionBlock)completionblock andCancelBlock:(AlertCancelBlock)cancelBlock;

@end
