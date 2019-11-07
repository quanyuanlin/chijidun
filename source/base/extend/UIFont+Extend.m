//
//  UIFont+Extend.m
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import "UIFont+Extend.h"

@implementation UIFont (Extend)

+(UIFont *)FontOfSize:(CGFloat)size
{
    UIFont *font;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_0) {
       font  =[UIFont fontWithName:@"PingFangSC-Regular" size:S(size)];
    }else{
       font  =[UIFont systemFontOfSize:S(size)];
    }
    return font;
}

+(UIFont *)LightFontOfSize:(CGFloat)size
{
    UIFont *font;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_0) {
        font  =[UIFont fontWithName:@"PingFangSC-Light" size:S(size)];
    }else{
        font  =[UIFont systemFontOfSize:S(size)];
    }
    return font;
}

+(UIFont *)MediumFontOfSize:(CGFloat)size
{
    UIFont *font;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_0) {
        font  =[UIFont fontWithName:@"PingFangSC-Medium" size:S(size)];
    }else{
        font  =[UIFont systemFontOfSize:S(size)];
    }
    return font;
}

+(UIFont *)BoldFontOfSize:(CGFloat)size
{
    UIFont *font;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_9_0) {
        font  =[UIFont fontWithName:@"PingFangSC-Semibold" size:S(size)];
    }else{
        font  =[UIFont systemFontOfSize:S(size)];
    }    
    return font;
}

@end
