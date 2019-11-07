//
//  AddressView.m
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import "AddressView.h"
#define AddressTableCell @"TeamAddressCell"
#define TableHeight 60.0

@interface AddressView ()
{
    UITableView *m_tableView;
    CGFloat width;
}
@end
@implementation AddressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addMainView];
    }
    return self;
}
-(void)addMainView
{
    width=kMainScreen_Width-2*kDistanceMin;
    UIView *view=[[UIView alloc]initWithFrame:self.bounds];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.6];
    [self addSubview:view];
    [view click:self action:@selector(removeView:)];
    
    
    CGFloat height=H(self)*0.5;
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(kDistanceMin, H(self)-height, width, height)];
    m_tableView.layer.cornerRadius=10.0f;
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    [self addSubview:m_tableView];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, TableHeight)];
    [lab setTextColor:BLUE_COLOR];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [lab setFont:[UIFont LightFontOfSize:16]];
    [lab setText:@"选择取餐地点"];
    m_tableView.tableHeaderView=lab;
    [lab.layer addSublayer:getLine(kDistanceMin, width-kDistanceMin, TableHeight, TableHeight, getUIColor(0xdddddd))];
    [m_tableView registerNib:[UINib nibWithNibName:AddressTableCell bundle:nil] forCellReuseIdentifier:AddressTableCell];
    
    
}
-(void)reloadDatas
{
    CGFloat height=self.arrList.count*60+60;
    if (height>kMainScreen_Height/2) {
        height=kMainScreen_Height/2;
    }
    [m_tableView setFrame:CGRectMake(kDistanceMin, kMainScreen_Height-height-kDistance, width, height)];
}

-(void)removeView:(id)sender
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
    return self.arrList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TableHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark tableview delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    TeamAddressCell *_cell = (TeamAddressCell *)[tableView dequeueReusableCellWithIdentifier:AddressTableCell forIndexPath:indexPath];
    _cell.selectionStyle=UITableViewCellSelectionStyleNone;
    TeamAddressTable *addr=_arrList[indexPath.row];
    if ([addr.Id isEqualToString:_selectId]) {
        [_cell.selectView setHidden:NO];
    }else{
        [_cell.selectView setHidden:YES];
    }
    [_cell.labTitle setText:addr.addr];
    cell=_cell;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TeamAddressTable *addr=_arrList[indexPath.row];
    _selectId=addr.Id;
    [m_tableView reloadData];
    if (self.clickBlock) {
        self.clickBlock(_arrList[indexPath.row]);
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (MODEL_VERSION >= 7.0) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
        }
        if (MODEL_VERSION >= 8.0) {
            if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
                [cell setPreservesSuperviewLayoutMargins:NO];
            }
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
            }
        }
    }
    
}

@end
