//
//  ScoreDetailViewController.m
//  
//
//  Created by iMac on 16/1/7.
//
//

#import "ScoreDetailViewController.h"
#define TableViewCell @"ScoreDetailCell"
@interface ScoreDetailViewController ()
{
    UITableView *m_tableView;
    NSMutableArray *m_arrayLists;
    NSInteger _currentPage;
}
@end

@implementation ScoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"积分明细";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    
    m_arrayLists=[NSMutableArray array];
    [self loadDataList];
    [self addTableView];
}
-(void)loadDataList
{
    UserScore_listRequest *request = [UserScore_listRequest new];
    request.page=[NSString stringWithFormat:@"%ld",++_currentPage];
    request.perPage=@"10";
    [apiClient doUserScore_list:request success:^(NSMutableDictionary *data, NSString *url) {
        UserScore_listResponse *response = [[UserScore_listResponse new] fromJSON:data];
        if (_currentPage==1) {
            m_arrayLists=[NSMutableArray arrayWithArray:response.data.list];
        }else{
            [m_arrayLists addObjectsFromArray:response.data.list];
        }
        [m_tableView reloadData];
    }];
}
-(void)addTableView
{
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height-65)];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    m_tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:m_tableView];
    
    [m_tableView registerNib:[UINib nibWithNibName:TableViewCell bundle:nil] forCellReuseIdentifier:TableViewCell];
    
    @weakify(self)
    m_tableView.mj_header = refresh_header1;
    self.refreshBlock = ^{
        @strongify(self)
        _currentPage = 0;
        [self loadDataList];
        [m_tableView.mj_header endRefreshing];
    };
    m_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadDataList];
        [m_tableView.mj_footer endRefreshing];
    }];

}
#pragma mark tableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_arrayLists.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight*1.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark tableview datasoure
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScoreDetailCell *cell=(ScoreDetailCell *) [tableView dequeueReusableCellWithIdentifier:TableViewCell forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell bindWith:m_arrayLists[indexPath.row]];
    return cell;
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











