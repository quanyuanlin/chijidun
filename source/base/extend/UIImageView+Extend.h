//
//  UIImageView+Extend.h
//  chijidun
//
//  Created by iMac on 16/9/3.
//
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extend)

- (void)load:(NSString *)url;

- (void)loadImage:(NSString *)url placeHolder:(NSString *)placeHolder;

@end
