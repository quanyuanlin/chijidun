//
//  RegisterViewController.h
//  chijidun
//
//  Created by iMac on 16/8/27.
//
//

#import "TBaseUIViewController.h"
#import "RegisterSecondViewController.h"

@interface RegisterViewController : TBaseUIViewController
<UITextFieldDelegate>

-(instancetype)initWithRestPsw:(BOOL)isRestPsw;

@end
