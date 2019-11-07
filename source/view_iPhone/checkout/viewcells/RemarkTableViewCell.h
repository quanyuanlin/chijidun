//
//  RemarkTableViewCell.h
//  insuny
//
//  Created by iMac on 15/8/22.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ConfirmOrderViewController.h"

@protocol RemarkTableViewCellDelegate <NSObject>

-(void)textViewDidEndWith:(NSString *)text;

@end
@interface RemarkTableViewCell : UITableViewCell
<UITextViewDelegate>

@property(nonatomic,weak) id<RemarkTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *smallLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;



@end
