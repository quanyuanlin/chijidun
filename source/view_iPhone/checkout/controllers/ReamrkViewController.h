//
//  ReamrkViewController.h
//  chijidun
//
//  Created by iMac on 16/11/14.
//
//

#import <UIKit/UIKit.h>
#import "RemarkButtonView.h"

@interface ReamrkViewController : TBaseUIViewController
<UITextViewDelegate>

@property(nonatomic,strong)NSArray *selectArrsys;
@property(nonatomic,strong)NSString *remarkText;
@property(nonatomic,strong)NSArray *remark_list;

@property (strong,nonatomic) void(^selectBlock)(NSString *remark,NSArray *arrayRemaks);


@end
