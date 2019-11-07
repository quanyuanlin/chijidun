#import "ChefDetailVC.h"
#import "ChefFoodsView.h"
#import "CommentDetailVC.h"
#import "MemberGetRequest.h"
#import "ApiClient.h"

@interface ChefDetailVC () <chefFoodsDelegate> {
    ChefFoodsView *chefFoodsView;    
    // 分享功能 辅助参数
    UIImageView *_ivShareImage;
    NSString *_strShareContent;
    NSString *_strShareTitle;
    NSString *_strShareUrl;
    NSString *_strShareImageLocalPath;
    MemberTable *m_memberTable;
    BOOL _isFirst;
}
@end

@implementation ChefDetailVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    if (_isFaverVC) {
        UDNavigationController *navi=[[UDNavigationController alloc]init];
        navi=(UDNavigationController *)self.parentViewController;
        [navi setAlph:0];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self loadWith:chefFoodsView.selectDate];
}
- (void)loadWith:(NSString *)date {
    if (_isFirst) {
        _isFirst=NO;
    }else{
        [progressbar removeFromSuperview];
    }
    MemberGetRequest *request = [MemberGetRequest new];
    request.Id = self.Id;
    request.days = date;
    request.pos_lat = [[NSString alloc] initWithFormat:@"%f", self.latt];
    request.pos_lng = [[NSString alloc] initWithFormat:@"%f", self.lngg];
    [apiClient doMemberGet:request success:^(NSMutableDictionary *data, NSString *url) {
        MemberGetResponse *response = [[MemberGetResponse new] fromJSON:data];
        m_memberTable=response.data;
        [chefFoodsView reloadDataWith:response.data];
        if (_selectItemId.length>0) {
            chefFoodsView.selectId=_selectItemId;
            _selectItemId=@"";
            [chefFoodsView scrollToCell];
        }
    }failure:^(NSMutableDictionary *data, NSString *url) {
        [chefFoodsView showEmptyView];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _isFirst=YES;
    chefFoodsView = [[ChefFoodsView alloc] init];
    chefFoodsView.p_chefFoodsDelegate = self;
    chefFoodsView.apiClient = self->apiClient;
    chefFoodsView.cgClient = self->cgClient;
    if (_isTomorrow) {
        chefFoodsView.selectDate = getTomorrow();
    }else{
        chefFoodsView.selectDate = getToday();
    }
    chefFoodsView.user = [[App shared] currentUser];
    self.view = chefFoodsView;
    [self loadWith:getToday()];
}

#pragma mark chefFoodsDelegate

- (void)goCommentViewWith:(NSString *)mid {
    CommentDetailVC *detail = [[CommentDetailVC alloc] init];
    detail.mid = mid;
    [self showNavigationView:detail];
}

- (void)clickBackButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickWith:(NSString *)date {
    [self loadWith:date];
    chefFoodsView.selectDate = date;
}

- (void)shareChef{
    int sinaMaxTextLen = 140;
    
    _strShareTitle=[NSString stringWithFormat:@"[%@]-在这里吃几顿家的味道！",m_memberTable.title];
    _strShareContent=@"吃几顿-专业的家庭厨房共享平台。这里的饭菜，和家里的味道一样呦~";
    NSString * _shareContent = _strShareContent;
    if (_shareContent.length > sinaMaxTextLen) {
        _shareContent = [[_strShareContent substringToIndex:sinaMaxTextLen - 5] stringByAppendingString:@"..."];
    }
    _strShareUrl=[NSString stringWithFormat:@"%@?id=%@",kshareUrl,self.Id];
    _strShareImageLocalPath=m_memberTable.img;
    [Share showShareMenuWithTitle:_strShareTitle
                          content:_shareContent
                              url:_strShareUrl
                          iconUrl:_strShareImageLocalPath
                         iconPath:nil
                           inView:self];
    
}

@end









