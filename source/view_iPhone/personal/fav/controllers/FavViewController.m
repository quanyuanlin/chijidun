//
//  FavViewController.m
//  insuny
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "FavViewController.h"
#import "FavTableViewCell.h"
#define FavTableCell @"FavTableViewCell"

@interface FavViewController ()
{
    int _currentPage;
    NSMutableArray *m_arrayList;
    
    UITableView *m_tableView;
}
@end

@implementation FavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    [self.navigationController.view.layer addSublayer:getLine(0, kMainScreen_Width, NAV_HEIGHT, NAV_HEIGHT, BORDER_COLOR)];
    self.title=@"我的私厨";

    _currentPage=1;
    m_arrayList=[NSMutableArray array];
    [self loadDataLists];
    [self adddMainView];
}
-(void)adddMainView
{
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, kMainScreen_Width, kMainScreen_Height-NAV_HEIGHT)];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    m_tableView.allowsSelection = NO;
    m_tableView.showsVerticalScrollIndicator=NO;
    [m_tableView registerNib:[UINib nibWithNibName:FavTableCell bundle:nil]  forCellReuseIdentifier:FavTableCell];
    [self.view addSubview:m_tableView];
    [m_tableView setBackgroundColor:BG_COLOR];
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 15)];
    [header setBackgroundColor:BG_COLOR];
    m_tableView.tableHeaderView=header;
    
    m_tableView.mj_header = refresh_header1;
    @weakify(self)
    self.refreshBlock = ^{
        @strongify(self)
        _currentPage=1;
        [self loadDataLists];
        [m_tableView.mj_header endRefreshing];
    };
    
    m_tableView.mj_header.automaticallyChangeAlpha = YES;
    m_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _currentPage++;
            [self loadDataLists];
            [m_tableView.mj_footer endRefreshing];
        });
    }];

    if (!m_emptyView) {
        m_emptyView=[[EmptyView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height-NAV_HEIGHT)];
        [m_emptyView setImage:@"order-empty" Title:@"您没有关注的私厨" SubTitle:nil];
        [self.view addSubview:m_emptyView];
    }
    [m_emptyView setHidden:YES];
}
-(void)loadDataLists
{
    MemberFavListsRequest *request = [MemberFavListsRequest new];
    request.page=[NSString stringWithFormat:@"%d",_currentPage];
    request.perPage=@"10";
    USER *user = [[App shared] currentUser];
    request.userid=toNSString(user.user_id);
    [cgClient hideProgress];
    [cgClient doMemberFavLists:request success:^(CGResponse *data, NSString *url) {
        MemberFavListsResponse *response=[[MemberFavListsResponse alloc]initWithCGResponse:data];
        if (_currentPage>1) {
            [m_arrayList addObjectsFromArray:response.list];
        }else{
            m_arrayList=[NSMutableArray arrayWithArray:response.list];
        }
        if (m_arrayList.count==0) {
            [m_emptyView setHidden:NO];
            [self.view setBackgroundColor:WHITE_COLOR];
        }else{
            [m_emptyView setHidden:YES];
            [self.view setBackgroundColor:BG_COLOR];
        }
        [m_tableView reloadData];
    }];
    
}

#pragma mark Table Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return m_arrayList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavTableViewCell *cell = (FavTableViewCell *)[tableView dequeueReusableCellWithIdentifier:FavTableCell forIndexPath:indexPath];
    [cell bindWith:m_arrayList[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChefDetailVC *detailVC = [[ChefDetailVC alloc]init];
    MemberTable *member=m_arrayList[indexPath.row];
    detailVC.Id=member.Id;
    detailVC.isFaverVC=YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消关注";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self deleteFavWith:m_arrayList[indexPath.row]];
    }
}
-(void)deleteFavWith:(MemberFavTable *)fav
{
    Member_favsDeleteRequest *request = [Member_favsDeleteRequest new];
    request.mid = fav.mid;
    [apiClient hideProgress];
    [apiClient doMember_favsDelete:request success:^(NSMutableDictionary *_data, NSString *url) {
        [self.view showHUD:@"取消收藏成功"];
        _currentPage=1;
        [self loadDataLists];
    }];
}

@end
