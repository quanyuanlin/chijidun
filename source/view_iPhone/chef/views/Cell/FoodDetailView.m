//
//  FoodDetailView.m
//  chijidun
//
//  Created by iMac on 16/12/6.
//
//

#import "FoodDetailView.h"
#define FoodDescCellIdentify @"FoodDetailDescCell"
#define FoodDetailCellIdentify @"FoodDetailTableViewCell"
#define Back_size 24
#define LabCartSize 22

@interface FoodDetailView ()
{
    UITableView *m_tableView;
    
    UIView *m_headerView;
    UIImageView *m_imgView;
    UIButton *m_backBtn;
}
@end
@implementation FoodDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addMainViewWith:frame];
    }
    return self;
}
-(void)addMainViewWith:(CGRect)frame
{
    m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, frame.size.height)];
    m_tableView.delegate = self;
    m_tableView.dataSource = self;
    m_tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:m_tableView];
    m_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [m_tableView registerNib:[UINib nibWithNibName:FoodDescCellIdentify bundle:nil] forCellReuseIdentifier:FoodDescCellIdentify];
    [m_tableView registerNib:[UINib nibWithNibName:FoodDetailCellIdentify bundle:nil] forCellReuseIdentifier:FoodDetailCellIdentify];
}
-(void)reloadSubViews
{
    CGFloat height=kMainScreen_Width*3/4;
    if (self.itemTable.is_hots.intValue==1) {
        height=kMainScreen_Width*3/5;
    }
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, height)];
    m_tableView.tableHeaderView=header;
    
    m_imgView=[[UIImageView alloc]initWithFrame:header.frame];
    [m_imgView loadImage:self.itemTable.img placeHolder:img_placehold_big];
    [header addSubview:m_imgView];
    
    m_backBtn=[[UIButton alloc]initWithFrame:CGRectMake(kDistance, 30, Back_size, Back_size)];
    [m_backBtn setImage:[UIImage imageNamed:@"detail_back"] forState:UIControlStateNormal];
    [m_backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:m_backBtn];
    
    m_headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, NAV_HEIGHT)];
    [m_headerView setBackgroundColor:NAVI_COLOR];
    [m_headerView setHidden:YES];
    [self addSubview:m_headerView];
    
    UIImageView *backView=[[UIImageView alloc]initWithFrame:CGRectMake(kDistance, kDistance+20, 16, 16)];
    [backView setImage:[UIImage imageNamed:@"icon-back-left"]];
    [backView click:self action:@selector(backBtnClicked:)];
    [m_headerView addSubview:backView];
    
    CGFloat orginX=(kMainScreen_Width-100)/2;
    UILabel *labelTitle=[[UILabel alloc]initWithFrame:CGRectMake(orginX, 32, 100, 20)];
    [labelTitle setTextColor:TEXT_DEEP];
    [labelTitle setFont:[UIFont LightFontOfSize:18]];
    [labelTitle setTextAlignment:NSTextAlignmentCenter];
    [labelTitle setText:@"菜品详情"];
    [m_headerView addSubview:labelTitle];
}
-(void)loadDetailData
{
    ItemGetRequest *request = [ItemGetRequest new];
    request.Id = self.itemTable.Id;
    [self.apiClient hideProgress];
    [self.apiClient doItemGet:request success:^(NSMutableDictionary *data, NSString *url) {
        ItemGetResponse *response = [[ItemGetResponse new] fromJSON:data];
        self.itemTable.img=response.data.img;
        self.itemTable.item_desc=response.data.item_desc;
        self.itemTable.material=response.data.material;
        [m_imgView loadImage:self.itemTable.img placeHolder:img_placehold_big];
        [m_tableView reloadData];
    }];
}
-(void)reloadData
{
    [m_tableView reloadData];
}
#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            if (self.itemTable.material.length>0) {
                CGFloat height=getTextHeight(self.itemTable.material, kMainScreen_Width-30, [UIFont LightFontOfSize:15]);
                return 65+height;
            }
            return CGFLOAT_MIN;
        }
        if (indexPath.row==1) {
            CGFloat height=getTextHeight(self.itemTable.item_desc, kMainScreen_Width-30, [UIFont LightFontOfSize:15]);
            return 65+height;
        }
    }
    CGFloat height=getTextHeight(self.itemTable.title, kMainScreen_Width-30, [UIFont LightFontOfSize:18]);
    return height+105;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 10.0f;
    }
    return CGFLOAT_MIN;
}

#pragma mark tableview datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0) {
        FoodDetailTableViewCell *_cell = (FoodDetailTableViewCell *) [tableView dequeueReusableCellWithIdentifier:FoodDetailCellIdentify forIndexPath:indexPath];
        _cell.isTomorrow=_isTomorrow;
        _cell.member=self.memberTable;
        [_cell bindWith:self.itemTable];
        
        __weak __typeof(&*_cell)weakCell =_cell;
        __block __typeof(self)bself = self;
        _cell.cartBlock=^(ItemTable *item,BOOL animated){
            if (animated) {
                CGRect parentRectA = [weakCell convertRect:weakCell.buttonCart.frame toView:self];
                CGRect parentRectB=CGRectMake(60, H(self)-25, 15, 15);
                UIImageView *redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LabCartSize, LabCartSize)];
                [redView setBackgroundColor:[UIColor redColor]];
                redView.layer.cornerRadius = LabCartSize/2;
                [bself addSubview:redView];
                [[ThrowLineTool sharedTool] throwObject:redView from:parentRectA.origin to:parentRectB.origin];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [redView removeFromSuperview];
                });
                
            }            
            if (self.cartBlock) {
                self.cartBlock(item);
            }
        };
        cell=_cell;
    }
    if (indexPath.section==1) {
        FoodDetailDescCell *_cell = (FoodDetailDescCell *) [tableView dequeueReusableCellWithIdentifier:FoodDescCellIdentify forIndexPath:indexPath];
        if (indexPath.row==0) {
            if (self.itemTable.material.length>0) {
                [_cell.contentView setHidden:NO];
                [_cell.labTitle setText:@"食材"];
                [_cell.labDesc setText:self.itemTable.material];
            }else{
                [_cell.contentView setHidden:YES];
            }
        }
        if (indexPath.row==1) {
            [_cell.labTitle setText:@"描述"];
            [_cell.labDesc setText:self.itemTable.item_desc];
        }
        cell= _cell;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)backBtnClicked:(id)sender
{
    if (self.removeBlock) {
        self.removeBlock();
    } 
    [self removeFromSuperview];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset > 0) {
        [m_headerView setHidden:NO];
        CGFloat alpha = MIN((yOffset)/64, 1);
        m_headerView.alpha = alpha;
        m_backBtn.hidden=YES;
    } else {
        [m_headerView setHidden:YES];
        m_headerView.alpha = 1;
        m_backBtn.hidden=NO;
    }
}


@end
