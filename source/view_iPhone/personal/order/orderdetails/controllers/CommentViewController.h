//
//  CommentViewController.h
//  insuny
//
//  Created by iMac on 15/8/24.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYQAssetPickerController.h"
#import "MessagePhotoMenuItem.h"
#import "ApiClient.h"
@interface CommentViewController : TBaseUIViewController
<UITextViewDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,MessagePhotoItemDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *addImgView;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *labPlaceholder;

- (IBAction)commitComment:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic,strong)ORDER *order;

@end
