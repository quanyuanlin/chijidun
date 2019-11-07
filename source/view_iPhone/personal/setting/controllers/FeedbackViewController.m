//
//  FeedbackViewController.m
//  insuny
//
//  Created by txj on 15/5/18.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"意见反馈";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    
    backend=[UserBackend shared];
    self.textEditor.delegate=self;
    self.textEditor.placeholder=@"请填写您的修改意见";
    self.submitButton.layer.cornerRadius=5;
    [self.submitButton setBackgroundColor:MAIN_COLOR];
    
    self.view.backgroundColor=BG_COLOR;
    
}

- (IBAction)submitBtn:(id)sender {
    [[backend requestUpdateUserSetting:4 withValue:self.textEditor.text]
     subscribeNext:[self didUpdate:@"反馈成功，我们会尽快处理。"]];
}
- (void(^)(RACTuple *))didUpdate:(NSString *)text
{
    @weakify(self)
    return ^(RACTuple *parameters) {
        @strongify(self)
        ResponseResult *rs=(ResponseResult *)parameters;
        if (rs.success) {
            if ([self.delegate respondsToSelector:@selector(didSubmitFeedback:)]) {
                [self.delegate didSubmitFeedback:self];
            }
        }
        else{
            [self.view showHUD:rs.messge];
        }
        
    };
}

//隐藏键盘，实现UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text

{
    if ([text isEqualToString:@"\n"]) {
        
        [self.textEditor resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;  
    
}
@end
