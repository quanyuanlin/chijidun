//
//  UIImageView+Extend.m
//  chijidun
//
//  Created by iMac on 16/9/3.
//
//

#import "UIImageView+Extend.h"

@implementation UIImageView (Extend)
- (void)load:(NSString *)url {
    [self sd_setImageWithURL:[NSURL URLWithString:url]];
}
- (void)loadImage:(NSString *)url placeHolder:(NSString *)placeHolder
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:placeHolder]];
}
@end
