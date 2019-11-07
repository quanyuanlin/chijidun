//
//  UITextField+Extend.h
//  chijidun
//
//  Created by iMac on 16/8/27.
//
//

#import <UIKit/UIKit.h>
#import "UIView+Extend.h"

@interface UITextField (Extend)

+(UITextField *)textFieldWithFrame:(CGRect)frame drawingLeft:(NSString *)icon;

- (void)setPlaceholder:(NSString *)holder Corlor:(UIColor *)color;

-(void)showDeleteView;

-(void)setLeftDistance:(CGFloat)height;

@end
