//
//  RemarkButtonView.h
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import <UIKit/UIKit.h>

@interface RemarkButtonView : UIView

@property(nonatomic,strong)NSArray *buttonLists;
@property(nonatomic,strong)NSArray *selectArrays;

-(void)setButtons:(NSArray *)array;

@property (strong,nonatomic) void(^selectBlock)(RemarkTable *item,BOOL select);

@end
