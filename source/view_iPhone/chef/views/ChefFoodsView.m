#import "ChefFoodsView.h"
#import "ShopCartView.h"
#import "ChefButtonView.h"
#import "FoodDescCell.h"
#import "MemberTable.h"
#import "Member_favsAddRequest.h"
#import "ApiClient.h"
#import "ChefDetailVC.h"

#define Btn_Size 44
#define Btn_Size2 38
#define kFirstHeight 70.0
#define LabCartSize 22

@interface ChefFoodsView ()
<UITableViewDataSource, UITableViewDelegate, chefButtonDelegate,shopCartViewDelegate>
{
    UITableView *m_tableView;
    MemberTable *data;

    UIView *m_headerView;

    UILabel *m_labTitle;
    UIImageView *coverImageView;
    UIImageView *memberAvatar;
    UIButton *m_btnComment;
    
    UIButton *m_likeBtn;
    UIButton *m_likeBtn2;
    UILabel *memberNameLabel;
    UILabel *memberCaixiLabel;
    UILabel *memberAddressLabel;
    UIView *authDetailView;
    UIImageView *approve;
    CGFloat scrollOffset;
    UILabel *expressLabel;
    UILabel *_labelFooter;
    
    UIImageView *m_locationView;
    UILabel *m_labAddress;

    ShopCartView *m_shopCartView;
    ChefStoryView *m_storyView;
    ChefButtonView *m_chefButtonView;
    NSInteger shopNum;

    BOOL isTableShow;
    BOOL isTomorrow;

    NSString *m_distance;
    UIView *m_naviView;
    UIView *m_shadowView;
    
    NSMutableArray *m_arrayHots;
    NSMutableArray *m_arrayItems;
    
    FoodCartView *m_cartView;
    BOOL _isCartShow;
    NSString *_freight;
    NSString *_freeMoney;
    NSString *m_expressPrice;
    
    NSMutableArray *m_cartArray;
    ChefWarnView *m_warnView;
    
    BOOL _isShowDetailView;
    
    FoodDetailView *m_detailView;
    EmptyView *m_emptyView;
}
@end
typedef enum {
    SECTION_LOCATION,
    SECTION_EXPRESS,
    SECTION_BUTTON,
    SECTION_HOT,
    SECTION_FOODS,
    SECTION_COUNT
} SECTIONS;
@implementation ChefFoodsView
@synthesize p_chefFoodsDelegate = m_chefFoodsDelegate;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubViews];
    }
    return self;
}
-(void)addSubViews
{
    //初始效果
    m_shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, NAV_HEIGHT)];
    [self addSubview:m_shadowView];
    
    UIButton *backBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, Btn_Size, Btn_Size)];
    [backBtn1 setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [backBtn1 setImage:[UIImage imageNamed:@"chef_backgray"] forState:UIControlStateNormal];
    [backBtn1 addTarget:self action:@selector(backFirst:) forControlEvents:UIControlEventTouchUpInside];
    [m_shadowView addSubview:backBtn1];
    
    UIButton *shareBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreen_Width - Btn_Size-5,20,Btn_Size, Btn_Size)];
    [shareBtn1 setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [shareBtn1 setImage:[UIImage imageNamed:@"chef_sharegray"] forState:UIControlStateNormal];
    [shareBtn1 addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [m_shadowView addSubview:shareBtn1];
    
    m_likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(shareBtn1.frame)-10-Btn_Size,20,Btn_Size, Btn_Size)];
    [m_likeBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [m_likeBtn addTarget:self action:@selector(memberFavsHandler:) forControlEvents:UIControlEventTouchUpInside];
    [m_shadowView addSubview:m_likeBtn];
    [self addSubview:m_shadowView];
    
    // 上移效果
    m_naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, NAV_HEIGHT)];
    [m_naviView setBackgroundColor:NAVI_COLOR];
    [self addSubview:m_naviView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 20, 30, 36)];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [backBtn setImage:[UIImage imageNamed:@"chef_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backFirst:) forControlEvents:UIControlEventTouchUpInside];
    [m_naviView addSubview:backBtn];
    
    m_labTitle=[[UILabel alloc]initWithFrame:CGRectMake(50, 20, kMainScreen_Width-100, kCellHeight)];
    [m_labTitle setTextColor:TEXT_DEEP];
    [m_labTitle setFont:[UIFont LightFontOfSize:18]];
    [m_labTitle setTextAlignment:NSTextAlignmentCenter];
    [m_naviView addSubview:m_labTitle];
    
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreen_Width - Btn_Size2-5, 20,Btn_Size2, Btn_Size2)];
    [shareBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [shareBtn setImage:[UIImage imageNamed:@"chef_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [m_naviView addSubview:shareBtn];
    
    m_likeBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(shareBtn.frame)-Btn_Size2-15,20,Btn_Size2, Btn_Size2)];
    [m_likeBtn2 setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [m_likeBtn2 addTarget:self action:@selector(memberFavsHandler:) forControlEvents:UIControlEventTouchUpInside];
    [m_naviView addSubview:m_likeBtn2];
    [m_naviView setHidden:YES];
}
-(void)loadGlobalSetting
{
    GlobalSettingRequest *request = [GlobalSettingRequest new];
    [self.cgClient doGlobalSetting:request success:^(CGResponse *_data, NSString *url) {
        GlobalSettingResponse *response=[[GlobalSettingResponse alloc]initWithCGResponse:_data];
        _freight=response.default_freight;
        _freeMoney=response.free_shipping_money;
        m_shopCartView.response=response;
        [self reloadFooterDatas];
        [m_tableView reloadData];
    }];
}
- (void)reloadDataWith:(MemberTable *)model {
    [self loadGlobalSetting];
    self.coverItems = [NSArray arrayWithArray:model.covers];    
    data = [[MemberTable alloc] init];
    data = model;
    [m_labTitle setText:data.title];
    if (m_tableView==nil) {
        [self addTableView];
    }
    m_arrayHots=[NSMutableArray array];
    m_arrayItems=[NSMutableArray array];
    
    int num=0;
    for (int i=0; i<data.items.count; i++) {
        ItemTable *item=data.items[i];
        if (_isShowDetailView) {
            if ([item.Id isEqualToString:m_detailView.itemTable.Id]) {
                m_detailView.itemTable.cart_num=item.cart_num;
                [m_detailView reloadData];
            }
        }
        if (item.is_hots.intValue==1) {
            [m_arrayHots addObject:item];
        }else{
            [m_arrayItems addObject:item];
        }
        num=num+item.cart_num.intValue;
    }
    if (num>0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"removeWarn"];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"removeWarn"];
    }
    
    if (data.covers.count > 0) {
        Member_imgTable *member_imgTable = data.covers[0];
        [memberAvatar load:data.img];
        [coverImageView load:member_imgTable.img];
    }
    [memberNameLabel setText:model.title];
    NSMutableAttributedString *caixiStr = [[NSMutableAttributedString alloc]
            initWithString:[[NSString alloc] initWithFormat:
                    @"%@  开放时间 %@:00-%@:00", model.caixi, model.stime, model.etime]];

    [caixiStr addAttribute:NSForegroundColorAttributeName
                     value:getUIColor(0xffaa35)
                     range:NSMakeRange(0, model.caixi.length)];
    memberCaixiLabel.attributedText = caixiStr;
    [memberAddressLabel setText:model.address];

    
    if ([data.is_member_favs intValue] ==1) {
        [m_likeBtn setImage:[UIImage imageNamed:@"chef_favergray"] forState:UIControlStateNormal];
        [m_likeBtn2 setImage:[UIImage imageNamed:@"chef_faver"] forState:UIControlStateNormal];
    }else{
        [m_likeBtn setImage:[UIImage imageNamed:@"chef_unfavergray"] forState:UIControlStateNormal];
        [m_likeBtn2 setImage:[UIImage imageNamed:@"chef_unfaver"] forState:UIControlStateNormal];
    }

    [m_btnComment setTitle:[NSString stringWithFormat:@"%@条评论",data.comment_num] forState:UIControlStateNormal];
    
    if (model.statusDistance.intValue==1) {
        if (model.status.intValue==0) {
            [self showFooterCartView];
            [m_shopCartView setHidden:NO];
            [_labelFooter setHidden:YES];
        }else if (model.status.intValue==1||model.status.intValue==2) {
            if ([_selectDate isEqualToString:getTomorrow()]) {
                isTomorrow=YES;
                [self showFooterCartView];
                [m_shopCartView setHidden:NO];
                [_labelFooter setHidden:YES];
            }else{
                [self addLabelWith:data.statusStr];
                [_labelFooter setHidden:NO];
                [m_shopCartView setHidden:YES];
            }
        }
    }else{
        [self addLabelWith:data.statusStr];
        [_labelFooter setHidden:NO];
        [m_shopCartView setHidden:YES];
    }
    [self reloadFooterDatas];
    
    [m_tableView reloadData];
}
-(void)reloadFooterDatas
{
    if (data.items.count > 0) {
        int i = 0;
        float price = 0;
        for (ItemTable *table in data.items) {
            i = i + [table.cart_num intValue];
            NSString *unitP = [NSString stringWithFormat:@"%.2f", [table.price floatValue]];
            price = price + [table.cart_num intValue] * [unitP floatValue];
        }
        shopNum = i;
        
        int t=(int)price;
        NSString *total=[NSString stringWithFormat:@"%.1f",price];
        if (price==t) {
            total=[NSString stringWithFormat:@"%d",t];
        }
        [m_shopCartView shopCartWith:i andPrice:total];
        
        float money=price-_freeMoney.intValue;
        if (money>=0) {
            m_expressPrice=@"0";
        }else{
            m_expressPrice=_freight;
        }
        if (shopNum==0) {
            [m_warnView removeFromSuperview];
        }
    }
}
-(void)scrollToCell
{
    NSInteger section = 0;
    NSInteger row = 0;
    for (int i=0; i<m_arrayHots.count; i++) {
        ItemTable *item=m_arrayHots[i];
        if ([_selectId isEqualToString:item.Id]) {
            section=3;
            row=i;
        }
    }
    
    for (int i=0; i<m_arrayItems.count; i++) {
        ItemTable *item=m_arrayItems[i];
        if ([_selectId isEqualToString:item.Id]) {
            section=4;
            row=i;
        }
    }
    [m_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
-(void)showEmptyView
{
    if (m_emptyView==nil) {
        m_emptyView=[[EmptyView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, kMainScreen_Width, kMainScreen_Height - kNAV_HEIGHT)];
    }
    [m_emptyView setImage:@"home_fail" Title:@"亲，网络不给力哦..." SubTitle:@""];
    [self addSubview:m_emptyView];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)addLabelWith:(NSString *)string
{
    if (_labelFooter==nil) {
        _labelFooter = [[UILabel alloc] initWithFrame:CGRectMake(0, kMainScreen_Height - 50, kMainScreen_Width, 50)];
        [_labelFooter setBackgroundColor:COLOR_MID_GRAY];
        [_labelFooter setTextColor:WHITE_COLOR];
        [_labelFooter setFont:[UIFont LightFontOfSize:17]];
        [_labelFooter setTextAlignment:NSTextAlignmentCenter];
    }
    [_labelFooter setText:string];
    [self addSubview:_labelFooter];
}
-(void)showFooterCartView
{
    if (m_shopCartView==nil) {
        m_shopCartView = [[ShopCartView alloc] initWithFrame:CGRectMake(0, kMainScreen_Height - 50, kMainScreen_Width, 50)];
        m_shopCartView.p_shopCartViewDelegate = self;
        [self addSubview:m_shopCartView];
    }
    [m_shopCartView setCartViewWith:data];
    
}
- (void)addTableView {
    CGFloat coverHeight = kMainScreen_Width / 5 * 3;

    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height - kCart_HEIGHT)];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    m_tableView.showsVerticalScrollIndicator = NO;
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self addSubview:m_tableView];
    [m_tableView setBackgroundColor:getUIColor(0xf8f8f8)];
    
    UIView *footer=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, 105)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, kCart_HEIGHT, kMainScreen_Width, 20)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"——· 没有啦 ·——"];
    [label setFont:[UIFont LightFontOfSize:15]];
    [label setTextColor:TEXT_LIGHT];
    [footer addSubview:label];
    m_tableView.tableFooterView=footer;

    [m_tableView registerNib:[UINib nibWithNibName:@"FoodHotCell" bundle:nil] forCellReuseIdentifier:@"FoodHotCell"];
    [m_tableView registerNib:[UINib nibWithNibName:@"FoodDescCell" bundle:nil] forCellReuseIdentifier:@"FoodDescCell"];

    int topOffset = kCellHeight * 4.8;
    m_tableView.contentInset = UIEdgeInsetsMake(coverHeight, 0, 0, 0);

    NSMutableArray *imagesURLStrings = [NSMutableArray array];
    for (int i = 0; i < self.coverItems.count; i++) {
        Member_imgTable *item = self.coverItems[i];
        [imagesURLStrings addObject:item.img];
    }

    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMainScreen_Width, coverHeight) imageURLStringsGroup:nil];
    cycleScrollView.showPageControl = NO;
    cycleScrollView.backgroundColor = WHITE_COLOR;
    cycleScrollView.autoScrollTimeInterval=4.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    });
    _header = [CExpandHeader expandWithScrollView:m_tableView expandView:cycleScrollView];

    m_headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, topOffset)];
    [m_headerView setBackgroundColor:WHITE_COLOR];
    [m_tableView addSubview:m_headerView];
    m_tableView.tableHeaderView = m_headerView;
    
    memberAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (CGFloat) (coverHeight * 0.4), (CGFloat) (coverHeight * 0.4))];
    memberAvatar.center = CGPointMake(kMainScreen_Width / 2, 0);
    memberAvatar.layer.cornerRadius = (CGFloat) (coverHeight * 0.2);
    memberAvatar.layer.masksToBounds = YES;
    memberAvatar.layer.borderWidth = 1;
    memberAvatar.layer.borderColor = COLOR_LIGHT_GRAY.CGColor;
    memberAvatar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [m_headerView addSubview:memberAvatar];

    UIButton *authBtn = [[UIButton alloc] initWithFrame:CGRectMake(
            memberAvatar.frame.origin.x,
            coverHeight * 0.2 - kCellHeight * 0.4,
            (CGFloat) (coverHeight * 0.4),
            (CGFloat) (kCellHeight * 0.6))];
    authBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [authBtn setImage:[UIImage imageNamed:@"approveBtn"] forState:UIControlStateNormal];
    [authBtn addTarget:self action:@selector(showApproveView:) forControlEvents:UIControlEventTouchUpInside];
    [m_tableView addSubview:authBtn];

    memberNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(
            0,
            0,
            (CGFloat) (kMainScreen_Width * 0.6),
            (CGFloat) (kCellHeight * 0.5+5))];
    [memberNameLabel setTextColor:TEXT_DEEP];
    [memberNameLabel setTextAlignment:NSTextAlignmentCenter];
    [memberNameLabel setFont:[UIFont LightFontOfSize:24]];
    memberNameLabel.center = CGPointMake(
            kMainScreen_Width / 2,
            coverHeight * 0.2 + kCellHeight
    );
    [m_headerView addSubview:memberNameLabel];

    memberCaixiLabel = [[UILabel alloc] initWithFrame:CGRectMake(
            0,
            0,
            (CGFloat) kMainScreen_Width,
            (CGFloat) (kCellHeight * 0.5))];
    [memberCaixiLabel setFont:[UIFont LightFontOfSize:13]];
    [memberCaixiLabel setTextColor:YELLOW_COLOR];
    [memberCaixiLabel setTextAlignment:NSTextAlignmentCenter];
    memberCaixiLabel.center = CGPointMake(
            kMainScreen_Width / 2,
            CGRectGetMaxY(memberNameLabel.frame) + 20
    );
    [m_headerView addSubview:memberCaixiLabel];

    UIButton *storyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [storyBtn addTarget:self action:@selector(storyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
     storyBtn.titleLabel.font = [UIFont LightFontOfSize:15];
    [storyBtn setTitle:@"私厨故事" forState:UIControlStateNormal];
    [storyBtn setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    storyBtn.center = CGPointMake(kMainScreen_Width / 4+15, CGRectGetMaxY(memberCaixiLabel.frame) + 30);
    storyBtn.layer.cornerRadius = 5.0f;
    storyBtn.layer.borderColor=YELLOW_COLOR.CGColor;
    storyBtn.layer.borderWidth=0.5f;
    [m_headerView addSubview:storyBtn];
    
    m_btnComment = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    m_btnComment.userInteractionEnabled = YES;
    [m_btnComment addTarget:self action:@selector(showCommentView) forControlEvents:UIControlEventTouchUpInside];
    m_btnComment.titleLabel.font = [UIFont LightFontOfSize:15];
    [m_btnComment setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    m_btnComment.center = CGPointMake(kMainScreen_Width*3/4-15, CGRectGetMaxY(memberCaixiLabel.frame) + 30);
    m_btnComment.layer.cornerRadius = 5.0f;
    m_btnComment.layer.borderColor=YELLOW_COLOR.CGColor;
    m_btnComment.layer.borderWidth=0.5f;
    [m_headerView addSubview:m_btnComment];
    
    [self bringSubviewToFront:m_shadowView];
    [self bringSubviewToFront:m_naviView];
}
-(void)share:(UIButton *)sender
{
    if ([m_chefFoodsDelegate respondsToSelector:@selector(shareChef)]) {
        [m_chefFoodsDelegate shareChef];
    }
}

- (void)showCommentView {
    if ([m_chefFoodsDelegate respondsToSelector:@selector(goCommentViewWith:)]) {
        [m_chefFoodsDelegate goCommentViewWith:data.Id];
    }
}

- (void)memberFavsHandler:(UIButton *)button {
    if ([data.is_member_favs intValue] > 0) {
        Member_favsDeleteRequest *request = [Member_favsDeleteRequest new];
        request.mid = data.Id;
        [_apiClient hideProgress];
        [_apiClient doMember_favsDelete:request success:^(NSMutableDictionary *_data, NSString *url) {
            data.is_member_favs = @"0";
            [m_likeBtn setImage:[UIImage imageNamed:@"chef_unfavergray"] forState:UIControlStateNormal];
            [m_likeBtn2 setImage:[UIImage imageNamed:@"chef_unfaver"] forState:UIControlStateNormal];
            [self showHUD:@"取消收藏成功"];
        }];
    } else {
        Member_favsAddRequest *request = [Member_favsAddRequest new];
        request.mid = data.Id;
        [_apiClient hideProgress];
        [_apiClient doMember_favsAdd:request success:^(NSMutableDictionary *_data, NSString *url) {
            data.is_member_favs = @"1";
            [m_likeBtn setImage:[UIImage imageNamed:@"chef_favergray"] forState:UIControlStateNormal];
            [m_likeBtn2 setImage:[UIImage imageNamed:@"chef_faver"] forState:UIControlStateNormal];
            [self showHUD:@"收藏成功"];
        }];
    }
}

// 监听scrollView，实现图片拉伸效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat coverHeight = NAV_HEIGHT;
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset < -coverHeight) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        CGFloat alpha1 = MIN(-yOffset-coverHeight/NAV_HEIGHT, 1);
        [m_shadowView setAlpha:alpha1];
        
        [m_naviView setHidden:YES];
    }else if (yOffset>=-coverHeight){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        CGFloat alpha = MIN((64+yOffset)/NAV_HEIGHT, 1);
        [m_naviView setAlpha:alpha];
        [m_naviView setHidden:NO];
        
        CGFloat alpha1 = MIN(-yOffset/NAV_HEIGHT, 1);
        [m_shadowView setAlpha:alpha1];
        
    }

}

#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SECTION_COUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==SECTION_HOT) {
        return m_arrayHots.count;
    }
    if (section == SECTION_FOODS) {
        return m_arrayItems.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == SECTION_LOCATION) {
        return 50;
    }
    if (indexPath.section == SECTION_EXPRESS) {
        return 80.0f;
    }
    if (indexPath.section == SECTION_BUTTON) {
        return kCellHeight;
    }
    if (indexPath.section == SECTION_HOT) {
        ItemTable *hot=m_arrayHots[indexPath.row];
        CGFloat height;
        if (hot.item_desc.length>0) {
            height=getTextHeight(hot.item_desc, kMainScreen_Width-40, [UIFont LightFontOfSize:12])+5;
        }
        return (kMainScreen_Width-40)*3/5+125+height;
    }
    if (indexPath.section == SECTION_FOODS) {
        return 120.f;
    }
    return kCellHeight * 1.2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==SECTION_LOCATION) {
        return 0.5f;
    }
    if (section==SECTION_HOT||section==SECTION_EXPRESS) {
        return 10.0f;
    }
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==SECTION_HOT||section==SECTION_EXPRESS) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kDistanceMin)];
        [view setBackgroundColor:getUIColor(0xf8f8f8)];
        return view;
    }
    return nil;
}
#pragma mark tableview datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentify = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==SECTION_LOCATION) {
        UIView *viewBack=[[UIView alloc]initWithFrame:CGRectMake(0, 1,kMainScreen_Width,50)];
        [viewBack setBackgroundColor:WHITE_COLOR];
        [viewBack.layer addSublayer:getLine(0, kMainScreen_Width, 0, 0, BORDER_COLOR)];
        [cell.contentView addSubview:viewBack];
        
        
        UIImageView *locView=[[UIImageView alloc]initWithFrame:CGRectMake(kMainScreen_Width*0.13, 17, 16, 16)];
        [locView setImage:[UIImage imageNamed:@"chef_location"]];
        [viewBack addSubview:locView];
        
        NSString *string=[NSString stringWithFormat:@"位置：%@",data.address];
        UILabel *labAdd=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(locView.frame)+5, 15, kMainScreen_Width*0.6, 20)];
        [labAdd setFont:[UIFont LightFontOfSize:13]];
        [labAdd setTextColor:TEXT_LIGHT];
        [labAdd setText:string];
        [viewBack addSubview:labAdd];
        NSMutableAttributedString *expressStr = [[NSMutableAttributedString alloc] initWithString:string];
        [expressStr addAttribute:NSForegroundColorAttributeName
                           value:YELLOW_COLOR
                           range:NSMakeRange(0, 3)];
        [labAdd setAttributedText:expressStr];
        
    }
    if (indexPath.section == SECTION_EXPRESS) {
        UIImageView *expView = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreen_Width*0.13, 8, 15, 15)];
        [expView setImage:[UIImage imageNamed:@"chef_desc"]];
        [cell.contentView addSubview:expView];
        
        NSString *string2;
        float km=[data.min_range floatValue]*1000;
        if (data.distance.floatValue <= km) {
            string2 = [NSString stringWithFormat:@"配送说明:小区周边%@公里配送\n相距: %@米 | 配送费：%@元\n%@元起送,满%@元免配送费",data.min_range,data.distance,_freight,data.min_price,_freeMoney];
        } else {
            string2 = [NSString stringWithFormat:@"配送说明:小区周边%@公里配送\n相距: %@米 | 超出配送范围\n%@元起送,满%@元免配送费",data.min_range,data.distance,data.min_price,_freeMoney];
        }
        
        NSMutableAttributedString *expressStr = [[NSMutableAttributedString alloc] initWithString:string2];
        [expressStr addAttribute:NSForegroundColorAttributeName
                           value:YELLOW_COLOR
                           range:NSMakeRange(0, 5)];
        
        if (expressLabel==nil) {
            expressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(expView.frame)+5, 8, (CGFloat) (kMainScreen_Width * 0.62), getTextHeight(string2, kMainScreen_Width * 0.62, [UIFont LightFontOfSize:14]))];
            [expressLabel setNumberOfLines:0];
            [expressLabel setFont:[UIFont LightFontOfSize:14]];
            [expressLabel setTextColor:TEXT_LIGHT];
        }
        expressLabel.attributedText = expressStr;
        [cell.contentView addSubview:expressLabel];
        
    }
    if (indexPath.section == SECTION_BUTTON) {
        m_chefButtonView = [[ChefButtonView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kCellHeight)];
        [m_chefButtonView changeWith:self.selectDate];
        m_chefButtonView.p_chefButtonDelegate = self;
        [cell addSubview:m_chefButtonView];
    }
    if (indexPath.section==SECTION_HOT) {
        FoodHotCell *cellHot = (FoodHotCell *)
        [tableView dequeueReusableCellWithIdentifier:@"FoodHotCell" forIndexPath:indexPath];
        cellHot.memberTable=data;
        
        if (data.statusDistance.intValue==1) {
            if (data.status.intValue==1||data.status.intValue==2) {
                if ([_selectDate isEqualToString:getTomorrow()]) {
                    cellHot.memberTable.is_open=@"1";
                }else{
                    cellHot.memberTable.is_open=@"0";
                }
            }
        }
        [cellHot bindWith:m_arrayHots[indexPath.row]];
        __weak __typeof(&*cellHot)weakCell =cellHot;
        __block __typeof(self)bself = self;
        cellHot.cartBlock=^(ItemTable *item,BOOL animated){
            if (animated) {
                CGRect parentRectA = [weakCell convertRect:weakCell.buttonAdd.frame toView:self];
                CGRect parentRectB=CGRectMake(60, H(self)-75, 15, 15);
                UIImageView *redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LabCartSize, LabCartSize)];
                [redView setBackgroundColor:[UIColor redColor]];
                redView.layer.cornerRadius = LabCartSize/2;
                [bself addSubview:redView];
                [[ThrowLineTool sharedTool] throwObject:redView from:parentRectA.origin to:parentRectB.origin];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [redView removeFromSuperview];
                });
                
            }
            [bself foodDidChangeWith:item];
        };

        
        cell=cellHot;
    }
    if (indexPath.section == SECTION_FOODS) {
        FoodDescCell *cellFood = (FoodDescCell *)
        [tableView dequeueReusableCellWithIdentifier:@"FoodDescCell" forIndexPath:indexPath];
        cellFood.memberTable=data;
        if (data.statusDistance.intValue==1) {
            if (data.status.intValue==1||data.status.intValue==2) {
                if ([_selectDate isEqualToString:getTomorrow()]) {
                    cellFood.memberTable.is_open=@"1";
                }else{
                    cellFood.memberTable.is_open=@"0";
                }
            }
        }
        [cellFood setSubviewWith:isTomorrow];
        if (data.items.count > 0) {
            int i = 0;
            float price = 0;
            for (ItemTable *table in data.items) {
                i = i + [table.cart_num intValue];
                NSString *unitP = [NSString stringWithFormat:@"%.2f", [table.price floatValue]];
                price = price + [table.cart_num intValue] * [unitP floatValue];
            }
            shopNum = i;
            [cellFood cellRefreshDataWith:m_arrayItems[indexPath.row] And:i];
        }
        if (indexPath.row==m_arrayItems.count-1) {
            [cellFood.labLine setHidden:YES];
        }else{
            [cellFood.labLine setHidden:NO];
        }
        
        __weak __typeof(&*cellFood)weakCell =cellFood;
        __block __typeof(self)bself = self;
        cellFood.cartBlock=^(ItemTable *item,BOOL animated){
            if (animated) {
                CGRect parentRectA = [weakCell convertRect:weakCell.addButton.frame toView:self];
                CGRect parentRectB=CGRectMake(60, H(self)-75, 15, 15);
                
                UIImageView *redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LabCartSize, LabCartSize)];
                [redView setBackgroundColor:[UIColor redColor]];
                redView.layer.cornerRadius = LabCartSize/2;
                [bself addSubview:redView];
                [[ThrowLineTool sharedTool] throwObject:redView from:parentRectA.origin to:parentRectB.origin];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [redView removeFromSuperview];
                });
                
            }
            [bself foodDidChangeWith:item];
        };
        
        cell = cellFood;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==SECTION_HOT) {
        [self showDetail:m_arrayHots[indexPath.row]];
    }
    if (indexPath.section==SECTION_FOODS) {
        [self showDetail:m_arrayItems[indexPath.row]];
    }
}
-(void)showDetail:(ItemTable *)item
{
    if (m_detailView==nil) {
        m_detailView = [[FoodDetailView alloc] initWithFrame:m_tableView.frame];
        m_detailView.apiClient=self.apiClient;
        m_detailView.cgClient=self.cgClient;
    }
    m_detailView.memberTable=data;
    m_detailView.itemTable=item;
    [m_detailView reloadSubViews];
    m_detailView.isTomorrow=isTomorrow;
    [m_detailView loadDetailData];
    m_detailView.cartBlock=^(ItemTable *item){
        [self foodDidChangeWith:item];
    };
    m_detailView.removeBlock=^(){
        _isShowDetailView=NO;
    };
    
    CABasicAnimation *animation = nil;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [animation setFromValue:@0.1];
    [animation setToValue:@1.0];
    [animation setDuration:0.25];
    [animation setRemovedOnCompletion:NO];
    [m_detailView.layer addAnimation:animation forKey:@"baseanimation"];
    
    [self addSubview:m_detailView];
    _isShowDetailView=YES;
    [self bringSubviewToFront:m_shopCartView];
}
#pragma mark chefButton delegate

- (void)ClickTodayOrTommorrowWith:(BOOL)isT{
    if (isTomorrow!=isT) {
        isTomorrow = isT;
        NSString *date;
        if (isTomorrow) {
            date = getTomorrow();
        } else {
            date = getToday();
        }
        if ([m_chefFoodsDelegate respondsToSelector:@selector(clickWith:)]) {
            [m_chefFoodsDelegate clickWith:date];
        }
    }
}

#pragma mark m_foodDescCellDelegate

- (void)foodDidChangeWith:(ItemTable *)cart
{
    if (m_warnView==nil) {
        m_warnView=[[ChefWarnView alloc]initWithFrame:CGRectMake(kDistance, CGRectGetMinY(m_shopCartView.frame)-75, kMainScreen_Width-2*kDistance, 45)];
    }
    m_warnView.removeBlock = ^(BOOL remove){
        [[NSUserDefaults standardUserDefaults] setBool:remove forKey:@"removeWarn"];
    };
    CartSetByMemberRequest *request = [CartSetByMemberRequest new];
    request.mid=data.Id;
    request.item_id = cart.Id;
    if (cart.cart_num.intValue==0) {
        request.type=@"delete";
    }else{
        request.type=@"update";
    }
    request.num = cart.cart_num;
    request.tomorrow=[NSString stringWithFormat:@"%d",isTomorrow];
    [self.cgClient hideProgress];
    [self.cgClient doCartSetByMember:request success:^(CGResponse *_data, NSString *url) {
        int num=0;
        for (ItemTable *table in data.items) {
            if ([cart.Id isEqualToString:table.Id]) {
                table.cart_num=cart.cart_num;
            }
            if (table.is_rice.intValue==1) {
                if (table.cart_num.intValue==0&&![[NSUserDefaults standardUserDefaults] boolForKey:@"removeWarn"]) {
                    if (!_isShowDetailView) {
                        [self addSubview:m_warnView];
                    }
                }else{
                    [m_warnView removeFromSuperview];
                }
            }
            num=num+table.cart_num.intValue;
        }
        if (num==0) {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"removeWarn"];
        }
        [self reloadFooterDatas];
        if ([cart.Id isEqualToString:m_detailView.itemTable.Id]) {
            m_detailView.itemTable.cart_num=cart.cart_num;
            [m_detailView reloadData];
        }
        [m_tableView reloadData];
    }];
}

- (void)backFirst:(id)sender {
    if ([m_chefFoodsDelegate respondsToSelector:@selector(clickBackButton)]) {
        [m_chefFoodsDelegate clickBackButton];
    }
}

- (void)showApproveView:(id)sender {
    authDetailView = [[UIView alloc] init];
    [authDetailView setFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
    [authDetailView setBackgroundColor:[UIColor blackColor]];
    [authDetailView setAlpha:0.5];
    [authDetailView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapApproveView:)];
    [authDetailView addGestureRecognizer:gesture];

    approve = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreen_Width * 0.15, kMainScreen_Height * 0.28, kMainScreen_Width * 0.7, kMainScreen_Width * 0.7*0.815)];
    [approve setImage:[UIImage imageNamed:@"approveView"]];
    [self addSubview:authDetailView];
    [self addSubview:approve];
}

- (void)tapApproveView:(UIGestureRecognizer *)gesture {
    [approve removeFromSuperview];
    [authDetailView removeFromSuperview];
}

-(void)showCartView
{
    if (_isCartShow) {
        [self removeCartView];
        return;
    }
    if (m_cartView==nil) {
        m_cartView=[[FoodCartView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height-50)];
    }
    m_cartArray=[NSMutableArray array];
    for (ItemTable *item in data.items) {
        if (item.is_rice.intValue==1) {
            [m_cartArray insertObject:item atIndex:0];
        }else{
            if (item.cart_num.intValue>0) {
                [m_cartArray addObject:item];
            }
        }
    }
    m_cartView.cartList=[NSMutableArray arrayWithArray:m_cartArray];
    [m_cartView reloadCartTable:YES];
    [m_shopCartView setCartBtnWith:NO];
    
    __block __typeof(self)weakSelf = self;
    m_cartView.removeBlock = ^()
    {
        [weakSelf removeCartView];
    };
    m_cartView.deleteBlock = ^()
    {
        [weakSelf deleteAllCart];
        [weakSelf removeCartView];
    };
    m_cartView.changeBlock = ^(ItemTable *item)
    {
        [weakSelf foodDidChangeWith:item];
    };
    [self.window addSubview:m_cartView];
    _isCartShow=YES;
}
-(void)removeCartView
{
    [m_warnView removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"removeWarn"];
    [m_cartView removeFromSuperview];
    [m_shopCartView setCartBtnWith:YES];
    _isCartShow=NO;
}
-(void)deleteAllCart
{
    CartSetByMemberRequest *request = [CartSetByMemberRequest new];
    request.mid=data.Id;
    request.item_id = @"all";
    request.num = @"0";
    request.type=@"delete";
    request.tomorrow=[NSString stringWithFormat:@"%d",isTomorrow];
    [self.cgClient hideProgress];
    [self.cgClient doCartSetByMember:request success:^(CGResponse *_data, NSString *url) {
        for (ItemTable *item in data.items) {
            if (item.cart_num.intValue>0) {
                item.cart_num=@"0";
            }
        }
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"removeWarn"];
        [m_tableView reloadData];
        [self reloadFooterDatas];
        if (_isShowDetailView) {
            m_detailView.itemTable.cart_num=@"0";
            [m_detailView reloadData];
        }
    }];

}
-(void)orderBtnClicked
{
    int riceNum=0;
    BOOL _hasRice = NO;
    for (ItemTable *item in data.items) {
        if (item.is_rice.intValue==1) {
            _hasRice=YES;
            riceNum=item.cart_num.intValue;
            break;
        }
    }
    if (_hasRice) {
        if (riceNum>0) {
            [self showCheckOutVC];
        }else{
            [self addNoRiceView];
        }
    }else{
        [self showCheckOutVC];
    }
}
-(void)showCheckOutVC
{
    if (_isCartShow) {
        [self removeCartView];
    }
    ChefDetailVC *chefVC = (ChefDetailVC *) self.nextResponder;
    CheckOutViewController *checkoutVC = [[CheckOutViewController alloc] initWithCart:isTomorrow];
    checkoutVC.member=data;
    checkoutVC.expressPrice=m_expressPrice;
    [chefVC showNavigationView:checkoutVC];
}

-(void)addNoRiceView
{
    CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:@"别忘记点米饭哦" andMessage:nil];
    view.animationType = AnimationTypeBigToSmall;
    view.titleTextColor = TEXT_DEEP;
    
    __block __typeof(self)weakSelf = self;
    [view addButtonWithTitle:@"添加米饭" color:BLUE_COLOR handler:^(CBWAlertView *alertView){
        if (!_isCartShow) {
            [weakSelf showCartView];
        }        
    }];
    [view addButtonWithTitle:@"立即下单" color:BLUE_COLOR handler:^(CBWAlertView *alertView) {
        [weakSelf showCheckOutVC];
    }];
    [view show];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (MODEL_VERSION >= 7.0) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if (MODEL_VERSION >= 8.0) {
            if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
                [cell setPreservesSuperviewLayoutMargins:NO];
            }
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
            }
        }
    }
    
}

-(void)storyBtnClicked:(UIButton *)button
{
    if (m_storyView==nil) {
        m_storyView=[[ChefStoryView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
        [m_storyView SetStory:data.info];
        [self.window addSubview:m_storyView];
    }else{
        [self.window addSubview:m_storyView];
    }
}

@end











