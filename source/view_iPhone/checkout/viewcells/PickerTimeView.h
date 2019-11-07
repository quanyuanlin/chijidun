//
//  PickerTimeView.h
//  insuny
//
//  Created by iMac on 15/8/22.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerTimeTableViewCell.h"

@protocol pickerTimeViewDelegate <NSObject>

-(void)confirmPickViewWith:(NSString *)days And:(NSString *)times;

@end
@interface PickerTimeView : UIView
<UITableViewDelegate,UITableViewDataSource>
{
    __weak id<pickerTimeViewDelegate> m_pickerTimeViewDelegate;
}
@property(nonatomic,weak) id<pickerTimeViewDelegate> p_pickerTimeViewDelegate;

@property(nonatomic,strong)NSMutableArray *timeArray;

-(void)reloadDataWith:(NSArray *)array and:(BOOL)isTomorrow;

@end
