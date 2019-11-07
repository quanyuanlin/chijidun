//
//  TeamSetViewController.m
//  chijidun
//
//  Created by iMac on 16/8/31.
//
//

#import "TeamSetViewController.h"

@interface TeamSetViewController ()
{
    UITableView *m_tableView;
    UISwitch *m_swith;
    UILabel *m_labDate;
    
    SwitchTable *_switchTable;
    NSDictionary *_dictData;
    
    NSMutableArray *_dateArray;
}
@end
@implementation TeamSetViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"点餐提醒";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    self.view.backgroundColor=getUIColor(0xf2f2f2);
    
    [self addMainView];
    [self getSwitchData];
    
    _dictData = @{@"2":@"周一",
                  @"4":@"周二",
                  @"8":@"周三",
                  @"16":@"周四",
                  @"32":@"周五",
                  @"64":@"周六",
                  @"1":@"周日",};
    
}
-(void)goBack
{
   [self dismissViewControllerAnimated:YES completion:nil];
    if (self.backBlock) {
        self.backBlock();
    }
}
-(void)addMainView
{
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    [self.view addSubview:m_tableView];
    
    UIView *header=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 10)];
    [header setBackgroundColor:getUIColor(0xf2f2f2)];
    m_tableView.tableHeaderView=header;
    
    UIView *footer=[[UITableView alloc]initWithFrame:CGRectMake(0,0, kMainScreen_Width, 10)];
    [footer setBackgroundColor:MAIN_COLOR];
    m_tableView.tableFooterView=header;
}
-(void)getSwitchData
{
    GetCompanyPushSwitchRequest *request = [GetCompanyPushSwitchRequest new];
    [cgClient doGetCompanyPushSwitch:request success:^(CGResponse *data, NSString *url) {
        GetCompanyPushSwitchResponse *response=[[GetCompanyPushSwitchResponse alloc]initWithCGResponse:data];
        _switchTable=response.data;
        [self recountData];
    }];
}
-(void)recountData
{
    _dateArray=[NSMutableArray array];
    int week=_switchTable.week.intValue;
    if (week>0) {
        NSArray *keyArrays=@[@"2",@"4",@"8",@"16",@"32",@"64",@"1"];
        for (NSString *sum in keyArrays) {
            int key=sum.intValue;
            if (week&key) {
                [_dateArray addObject:[_dictData objectForKey:sum]];
            }
        }
        [m_tableView reloadData];
    }
}
-(void)loadData
{
    CompanyPushSwitchRequest *request = [CompanyPushSwitchRequest new];
    request.on=_switchTable.on;
    request.week=_switchTable.week;
    [cgClient doCompanyPushSwitch:request success:^(CGResponse *data, NSString *url) {
        [self recountData];
    }];
}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}
#pragma mark tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCart_HEIGHT;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSArray *array=@[@"点餐提醒",@"重复"];
    [cell.textLabel setText:array[indexPath.row]];
    if (indexPath.row==0) {
        if (m_swith==nil) {
            m_swith=[[UISwitch alloc]initWithFrame:CGRectMake(kMainScreen_Width-kDistance-50, 10, 50, 30)];
        }
        if (_switchTable.on.intValue==1) {
            [m_swith setOn:YES];
        }
        [m_swith addTarget: self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:m_swith];
    }
    if (indexPath.row==1) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (m_labDate==nil) {
            m_labDate=[[UILabel alloc]initWithFrame:CGRectMake(kMainScreen_Width-30-240, 10, 240, 30)];
            [m_labDate setTextAlignment:NSTextAlignmentRight];
            [m_labDate setTextColor:getUIColor(0x666666)];
        }
        if (_switchTable.week.intValue==127) {
            [m_labDate setText:@"每天"];
        }else if (_switchTable.week.intValue==62){
            [m_labDate setText:@"工作日"];
        }else{
            [m_labDate setText:[_dateArray componentsJoinedByString:@","]];
        }
        [cell.contentView addSubview:m_labDate];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==1) {
        DateSetViewController *setVC=[[DateSetViewController alloc]init];
        setVC.switchTable=_switchTable;
        setVC.switchBlock=^(SwitchTable *switchTable){
            _switchTable=switchTable;
            [self loadData];
        };
        [self showNavigationView:setVC];
    }
}
-(void)switchValueChanged:(UISwitch *)switchBtn
{
    _switchTable.on=[NSString stringWithFormat:@"%d",switchBtn.on];
    [self loadData];
}

@end







