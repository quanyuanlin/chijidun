//
//  CharacterPayView.h
//  chijidun
//
//  Created by iMac on 16/10/12.
//
//

#import <UIKit/UIKit.h>
#import "EnterCodeView.h"

@interface CharacterPayView : UIView

@property (strong,nonatomic) void(^codeBlock)(NSString *code);

@end
