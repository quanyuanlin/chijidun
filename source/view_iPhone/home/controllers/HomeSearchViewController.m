//
//  HomeSearchViewController.m
//  chijidun
//
//  Created by iMac on 16/12/8.
//
//

#import "HomeSearchViewController.h"
#define SearchHeaderCellIdentify @"SearchTableViewCellHeader"
#define SearchCellIdentify @"SearchResultTableViewCell"
#define kLeftDistance 37

@interface HomeSearchViewController ()
{
    UITextField *m_searchTF;
    
    UITableView *m_tableView1;
    UITableView *m_tableView2;
    UIView *_header;
    
    NSArray *_historyArray;
    NSMutableArray *_arrayLists;
    EmptyView *m_emptyView;
    
    int _currentPage;
}
@end

@implementation HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrayLists=[NSMutableArray array];
    _currentPage=1;
    [self addMainView];
    [self loadHistoryData];
}
-(void)addMainView
{
    [self.view setBackgroundColor:WHITE_COLOR];
    UDNavigationController *navi=(UDNavigationController *)self.navigationController;
    navi.alphaView.backgroundColor=WHITE_COLOR;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(-15/2, -kDistanceMin, kMainScreen_Width, NAV_HEIGHT)];
    
    m_searchTF=[[MYTextField alloc]initWithFrame:CGRectMake(kDistance/2, 17, kMainScreen_Width-60-kDistance,27)drawingLeft:@"home_searchBtn"];
    m_searchTF.layer.cornerRadius = 27/2;
    m_searchTF.layer.borderWidth = 1;
    m_searchTF.clearButtonMode=UITextFieldViewModeWhileEditing;
    m_searchTF.layer.borderColor = BORDER_COLOR.CGColor;
    [m_searchTF setTextColor:TEXT_MIDDLE];
    [m_searchTF setPlaceholder:@"可搜索私厨名、菜品名" Corlor:DISABLE_COLOR];
    [m_searchTF setFont:[UIFont LightFontOfSize:14]];
    m_searchTF.backgroundColor = WHITE_COLOR;
    m_searchTF.delegate=self;
    m_searchTF.returnKeyType=UIReturnKeySearch;
    [m_searchTF becomeFirstResponder];
    [titleView addSubview:m_searchTF];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(m_searchTF.frame)+kDistance, 17, 35, 27)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RED_COLOR forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [cancelBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:cancelBtn];
    self.navigationItem.titleView=titleView;
    
    m_tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kMainScreen_Width,kMainScreen_Height-NAV_HEIGHT)];
    m_tableView1.delegate = self;
    m_tableView1.dataSource = self;
    [self.view addSubview:m_tableView1];
    //[m_tableView1 setHidden:YES];
    
    m_tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kMainScreen_Width,kMainScreen_Height-NAV_HEIGHT)];
    m_tableView2.separatorStyle=UITableViewCellSeparatorStyleNone;
    m_tableView2.delegate = self;
    m_tableView2.dataSource = self;
    [self.view addSubview:m_tableView2];
    [m_tableView2 setHidden:YES];
    [m_tableView2 registerNib:[UINib nibWithNibName:SearchHeaderCellIdentify bundle:nil] forCellReuseIdentifier:SearchHeaderCellIdentify];
    [m_tableView2 registerNib:[UINib nibWithNibName:SearchCellIdentify bundle:nil] forCellReuseIdentifier:SearchCellIdentify];
    
    if (m_emptyView==nil) {
        m_emptyView=[[EmptyView alloc]initWithFrame:m_tableView2.bounds];
        [m_emptyView setImage:@"order-empty" Title:@"找不到?换个关键字搜索" SubTitle:nil];
        [m_tableView2 addSubview:m_emptyView];
    }
    [m_emptyView setHidden:YES];
    
    _header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 35)];
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(kDistance, 22, 13, 13)];
    [imgView setImage:[UIImage imageNamed:@"search_history"]];
    [_header addSubview:imgView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame)+5, 22, 100, 13)];
    [label setText:@"搜索历史"];
    [label setFont:[UIFont LightFontOfSize:14]];
    [label setTextColor:TEXT_LIGHT];
    [_header addSubview:label];
    
    UIButton *buttonDelete=[[UIButton alloc]initWithFrame:CGRectMake(kMainScreen_Width-4-38, 0, 38, 35)];
    [buttonDelete setImage:[UIImage imageNamed:@"icon-del"] forState:UIControlStateNormal];
    [buttonDelete setImageEdgeInsets:UIEdgeInsetsMake(17/2, 10, 17/2, 10)];
    [buttonDelete addTarget:self action:@selector(buttonClearClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_header addSubview:buttonDelete];
}
-(void)buttonClearClicked:(UIButton *)button
{
    CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:@"清除历史记录" andMessage:nil];
    view.animationType = AnimationTypeBigToSmall;
    view.titleTextColor = TEXT_DEEP;
    [view addButtonWithTitle:@"取消" color:TEXT_MIDDLE handler:^(CBWAlertView *alertView){
    }];
    [view addButtonWithTitle:@"确定" color:BLUE_COLOR handler:^(CBWAlertView *alertView) {
    }];
    [view show];
}
-(void)loadHistoryData
{
    SearchHistoryRequest *request = [SearchHistoryRequest new];
    [cgClient hideProgress];
    [cgClient doSearchHistory:request success:^(CGResponse *_data, NSString *url) {
        SearchHistoryResponse *response=[[SearchHistoryResponse alloc]initWithCGResponse:_data];
        _historyArray=[NSArray arrayWithArray:response.list];
        if (_historyArray.count==0) {
            m_tableView1.tableHeaderView=nil;
        }else{
            m_tableView1.tableHeaderView=_header;
        }
        [m_tableView1 reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==m_tableView2) {
        return _arrayLists.count;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==m_tableView2) {
        MemberTable *member=_arrayLists[section];
        return member.items.count+1;
    }
    return _historyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    if (tableView==m_tableView1) {
        [cell.textLabel setFont:[UIFont LightFontOfSize:17]];
        [cell.textLabel setTextColor:TEXT_DEEP];
        [cell.textLabel setText:_historyArray[indexPath.row]];
    }
    if (tableView==m_tableView2) {
        if (indexPath.row==0) {
            SearchTableViewCellHeader *_cell = (SearchTableViewCellHeader *) [tableView dequeueReusableCellWithIdentifier:SearchHeaderCellIdentify forIndexPath:indexPath];
            [_cell bindWith:_arrayLists[indexPath.section]];
            cell=_cell;
        }else{
            SearchResultTableViewCell *_cell = (SearchResultTableViewCell *) [tableView dequeueReusableCellWithIdentifier:SearchCellIdentify forIndexPath:indexPath];
            _cell.searchText=m_searchTF.text;
            MemberTable *member=_arrayLists[indexPath.section];
            [_cell bindWith:member.items[indexPath.row-1]];
            if (indexPath.row==member.items.count) {
                [_cell.lineView setHidden:YES];
            }else{
                [_cell.lineView setHidden:NO];
            }
            cell=_cell;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==m_tableView2) {
        if (indexPath.row==0) {
            return 70;
        }
        MemberTable *member=_arrayLists[indexPath.section];
        if (indexPath.row==member.items.count) {
            return 130;
        }
        return 120;
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView==m_tableView2) {
        return 1.0f;
    }
    return CGFLOAT_MIN;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView==m_tableView1) {
        [m_searchTF setText:_historyArray[indexPath.row]];
        [self loadSearchWith:_historyArray[indexPath.row]];
    }else{
        MemberTable *member=_arrayLists[indexPath.section];
        ItemTable *item;
        if (indexPath.row>0) {
            item=member.items[indexPath.row-1];
        }
        [self showChefDetailWith:member :item];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (MODEL_VERSION >= 7.0) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, kLeftDistance, 0, 0)];
        }
        if (MODEL_VERSION >= 8.0) {
            if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
                [cell setPreservesSuperviewLayoutMargins:NO];
            }
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:UIEdgeInsetsMake(0, kLeftDistance, 0, 0)];
            }
        }
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [m_searchTF resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self loadSearchWith:textField.text];
    [textField resignFirstResponder];
    return YES;
}
-(void)loadSearchWith:(NSString *)text
{
    if (text.length==0) {
        [_arrayLists removeAllObjects];
        [m_tableView2 reloadData];
        [m_emptyView setHidden:NO];
        return;
    }
    MemberSearchRequest *request = [MemberSearchRequest new];
    request.key=text;
    request.pos_lat = [[NSString alloc] initWithFormat:@"%f", self.latt];
    request.pos_lng = [[NSString alloc] initWithFormat:@"%f", self.lngg];
    request.page = [NSString stringWithFormat:@"%d",_currentPage];
    request.perPage = @"10";
    request.city=_city;
    [cgClient hideProgress];
    [cgClient doMemberSearch:request success:^(CGResponse *_data, NSString *url) {
        MemberSearchResponse *response=[[MemberSearchResponse alloc]initWithCGResponse:_data];
        _arrayLists=response.data.list;
        if (_arrayLists.count==0) {
            [m_emptyView setHidden:NO];
        }else{
            [m_emptyView setHidden:YES];
        }
        [m_tableView2 setHidden:NO];
        [m_tableView2 reloadData];
    }];
}

-(void)showChefDetailWith:(MemberTable *)member :(ItemTable *)item
{
    ChefDetailVC *detailVC = [[ChefDetailVC alloc]init];
    detailVC.Id = member.Id;
    detailVC.latt=self.latt;
    detailVC.lngg=self.lngg;
    detailVC.selectItemId=item.Id;
    if (member.statusDistance.intValue==1&&member.statusTomorrow.intValue==1) {
        if (member.status.intValue==1||member.status.intValue==2) {
            detailVC.isTomorrow=YES;
        }
    }
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:detailVC];
    [self presentViewController:navigationController animated:NO completion:^{
    }];
}

@end
