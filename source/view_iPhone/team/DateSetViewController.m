//
//  DateSetViewController.m
//  chijidun
//
//  Created by iMac on 16/8/31.
//
//

#import "DateSetViewController.h"

#define TeamCellIdentify @"TeamSetCell"
@interface DateSetViewController ()
{
    UITableView *m_tableView;
    NSArray *m_array;
    
    NSDictionary *_dictData;
    
    int _week;
}
@end
@implementation DateSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"重复";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    self.view.backgroundColor=getUIColor(0xf2f2f2);

    _week=_switchTable.week.intValue;
    
    _dictData = @{@"周一":@"2",
                  @"周二":@"4",
                  @"周三":@"8",
                  @"周四":@"16",
                  @"周五":@"32",
                  @"周六":@"64",
                  @"周日":@"1"};
    m_array=[_dictData allKeys];
    m_array=@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    [self addMainView];
}
-(void)addMainView
{
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    [self.view addSubview:m_tableView];
    [m_tableView registerNib:[UINib nibWithNibName:TeamCellIdentify bundle:nil] forCellReuseIdentifier:TeamCellIdentify];
    
    UIView *header=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 10)];
    [header setBackgroundColor:getUIColor(0xf2f2f2)];
    m_tableView.tableHeaderView=header;
    
    UIView *footer=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 10)];
    [footer setBackgroundColor:WHITE_COLOR];
    m_tableView.tableFooterView=header;

}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_array.count;
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
    TeamSetCell *cell = (TeamSetCell *)[tableView dequeueReusableCellWithIdentifier:TeamCellIdentify forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell bind];
    [cell.labTitle setText:m_array[indexPath.row]];
    
    NSString *select=[_dictData objectForKey:m_array[indexPath.row]];
    if (_week&[select intValue]) {
        [cell.selectView setHidden:NO];
        [cell.contentView setBackgroundColor:getUIColor(0xf8f8f8)];
    }else{
        [cell.selectView setHidden:YES];
        [cell.contentView setBackgroundColor:WHITE_COLOR];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TeamSetCell *cell = [tableView cellForRowAtIndexPath:indexPath];    
    int selectValue=[[_dictData objectForKey:m_array[indexPath.row]] intValue];
    if (_week&selectValue) {
        _week=_week-selectValue;
        [cell.selectView setHidden:YES];
        [cell.contentView setBackgroundColor:WHITE_COLOR];
    }else{
        _week=_week+selectValue;
        [cell.selectView setHidden:NO];
        [cell.contentView setBackgroundColor:getUIColor(0xf8f8f8)];
    }
    _switchTable.week=[NSString stringWithFormat:@"%d",_week];
}

-(void)goBack
{
    if (self.switchBlock) {
        self.switchBlock(_switchTable);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
