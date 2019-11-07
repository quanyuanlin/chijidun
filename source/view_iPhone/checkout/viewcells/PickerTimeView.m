//
//  PickerTimeView.m
//  insuny
//
//  Created by iMac on 15/8/22.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "PickerTimeView.h"
#define BtnHeight 40
#define kTableHeight 220
#define kLeftWidth 60

#define PickerTimeCell @"PickerTimeTableViewCell"
@interface PickerTimeView()
{
    UIView *m_backView;
    UITableView *m_tableView;
    
    NSString *m_selectDate;
    NSString *m_selectTime;
    
    UILabel *m_labDate;
    NSInteger _selectIndex;
}
@end
@implementation PickerTimeView
@synthesize p_pickerTimeViewDelegate=m_pickerTimeViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}
-(void)reloadDataWith:(NSArray *)array and:(BOOL)isTomorrow
{
    self.timeArray=[NSMutableArray arrayWithArray:array];
    if (self.timeArray.count>0) {
        m_selectTime=self.timeArray[0];
    }
    if (isTomorrow) {
        m_selectDate=@"明天";
    }else{
        m_selectDate=@"今天";
    }
    [m_labDate setText:m_selectDate];
    [m_tableView reloadData];
}
-(void)addSubviews
{
    UIView *viewBg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
    [viewBg setBackgroundColor:[UIColor blackColor]];
    [viewBg setAlpha:0.6];
    [self addSubview:viewBg];
    [viewBg click:self action:@selector(cancelPickerView:)];
    
    m_backView=[[UIView alloc]initWithFrame:CGRectMake(0, kMainScreen_Height-kTableHeight, kMainScreen_Width, kTableHeight)];
    [m_backView setBackgroundColor:WHITE_COLOR];
    [self addSubview:m_backView];
    
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(kLeftWidth, kDistanceMin, kMainScreen_Width-kLeftWidth, kTableHeight-kDistanceMin*2)];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    m_tableView.bounces=NO;
    [m_backView addSubview:m_tableView];
    [m_tableView registerNib:[UINib nibWithNibName:PickerTimeCell bundle:nil] forCellReuseIdentifier:PickerTimeCell];
    
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, kDistanceMin, kLeftWidth, kTableHeight-kDistanceMin)];
    [leftView setBackgroundColor:BG_COLOR];
    [m_backView addSubview:leftView];
    m_labDate =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kLeftWidth, kCart_HEIGHT)];
    [m_labDate setBackgroundColor:WHITE_COLOR];
    [m_labDate setTextColor:TEXT_MIDDLE];
    [m_labDate setFont:[UIFont LightFontOfSize:16]];
    [m_labDate setTextAlignment:NSTextAlignmentCenter];
    [leftView addSubview:m_labDate];
    
}
#pragma mark action
-(void)cancelPickerView:(id)sender
{
    [self removeFromSuperview];
}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.timeArray.count;
}
#pragma mark tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCart_HEIGHT;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PickerTimeTableViewCell *cell = (PickerTimeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:PickerTimeCell forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell bindWith:self.timeArray[indexPath.row]];
    
    if (indexPath.row==_selectIndex) {
        [cell.iconView setHidden:NO];
        [cell.labTitle setTextColor:TEXT_DEEP];
    }else{
        [cell.iconView setHidden:YES];
        [cell.labTitle setTextColor:TEXT_LIGHT];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectIndex=indexPath.row;
    [m_tableView reloadData];
    
    m_selectTime=self.timeArray[indexPath.row];
    if ([m_pickerTimeViewDelegate respondsToSelector:@selector(confirmPickViewWith: And:)]) {
        [m_pickerTimeViewDelegate confirmPickViewWith:m_selectDate And:m_selectTime];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
}

@end








