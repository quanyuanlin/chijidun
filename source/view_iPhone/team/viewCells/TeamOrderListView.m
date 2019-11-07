//
//  TeamOrderListView.m
//  chijidun
//
//  Created by iMac on 16/9/21.
//
//

#import "TeamOrderListView.h"

#define TeamCellIdentify @"TeamOrderListCell"
@interface TeamOrderListView ()
{
    UITableView *m_tableView;
    BOOL _isFirst;
}
@end
@implementation TeamOrderListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addMainTableView];
    }
    return self;
}
-(void)addMainTableView
{
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height-kNAV_HEIGHT-NAV_HEIGHT)];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    [self addSubview:m_tableView];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [m_tableView registerNib:[UINib nibWithNibName:TeamCellIdentify bundle:nil] forCellReuseIdentifier:TeamCellIdentify];
    
    UIView *header=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 15)];
    m_tableView.tableHeaderView=header;

    MJRefreshGifHeader *gifheader1 = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDatas:)];
    NSMutableArray *images=[NSMutableArray array];
    for (int i=0; i<4; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"refresh_%d",i]];
        [images addObject:image];
    }
    [gifheader1 setImages:images forState:MJRefreshStateIdle];
    [gifheader1 setImages:images forState:MJRefreshStatePulling];
    [gifheader1 setImages:images forState:MJRefreshStateRefreshing];
    [gifheader1 setTitle:@"释放即可刷新" forState:MJRefreshStateIdle];
    [gifheader1 setTitle:@"释放即可刷新" forState:MJRefreshStatePulling];
    [gifheader1 setTitle:@"努力刷新中" forState:MJRefreshStateRefreshing];
    gifheader1.lastUpdatedTimeLabel.hidden = YES;
    gifheader1.stateLabel.font = [UIFont LightFontOfSize:11];
    gifheader1.stateLabel.textColor=TEXT_LIGHT;
    m_tableView.mj_header=gifheader1;
}
-(void)refreshDatas:(id)sender
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.refreshBlock) {
            self.refreshBlock();
        }
        [m_tableView.mj_header endRefreshing];
    });
}
-(void)reloadDatasWith:(BOOL)isFirst
{
    _isFirst=isFirst;
    [m_tableView reloadData];
}

#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lists.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}
#pragma mark tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    TeamOrderListCell *_cell = (TeamOrderListCell *)[tableView dequeueReusableCellWithIdentifier:TeamCellIdentify forIndexPath:indexPath];
    _cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [_cell bindWith:self.lists[indexPath.row]];
    cell=_cell;
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isFirst) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
        [UIView animateWithDuration:0.5 animations:^{
            
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
            
        }completion:^(BOOL finish){
            _isFirst=NO;
        }];
    }    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderIndexTable *item=self.lists[indexPath.row];
    if (item.disable.intValue==0) {
        if (item.state.intValue!=3) {
            TeamOrderListVC *teamVC = (TeamOrderListVC *) self.nextResponder;
            TeamOrderDetailVC *detail=[[TeamOrderDetailVC alloc]init];
            detail.index=self.lists[indexPath.row];
            //[teamVC showNavigationView:detail];
            [teamVC presentVC:detail];
        }
    }    
}








@end
