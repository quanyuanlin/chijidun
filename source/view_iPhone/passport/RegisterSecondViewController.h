//
//  RegisterSecondViewController.h
//  chijidun
//
//  Created by iMac on 16/8/27.
//
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface RegisterSecondViewController : TBaseUIViewController
<UITextFieldDelegate>

-(instancetype)initWithRestPsw:(BOOL)isRestPsw;

@property(nonatomic,strong) NSString *tele;
@property(nonatomic,strong) NSString *code;


@end
