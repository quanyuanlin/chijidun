#import "CommentDetailView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "Member_commentListsRequest.h"
#import "Member_commentListsResponse.h"
#import "ApiClient.h"
#import "UIImageView+Extend.h"

#define kImgWidth 50
#define kIMgHeigth 50

@interface CommentDetailView () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *m_tableView;
    Item_commentTable *m_commentModel;

    UIImageView *m_iconView;
    UILabel *m_labName;
    UILabel *m_labContent;
    UILabel *m_labTime;
    NSArray *m_imgArray;
    NSMutableArray *list;
    int page;

    UILabel *m_labReply;
    UILabel *m_labReplyTime;
    UIView *m_emptyView;
}
@end

@implementation CommentDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        page = 0;
        list = [NSMutableArray new];
        m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height - kNAV_HEIGHT - 10)];
        [m_tableView setBackgroundColor:BG_COLOR];
        m_tableView.delegate = self;
        m_tableView.dataSource = self;
        m_tableView.showsVerticalScrollIndicator = NO;
        m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:m_tableView];

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
        m_tableView.mj_header.automaticallyChangeAlpha = YES;
        m_tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self load];
                [m_tableView.mj_footer endRefreshing];
            });
        }];
    }
    return self;
}
-(void)refreshDatas:(id)sender
{
    page = 0;
    [self load];
    [m_tableView.mj_header endRefreshing];
}
-(void)refreshWith:(NSString *)reply
{
    self.reply=reply;
    page=0;
    [self load];
}
- (void)load{
    page++;
    if (page <= 1) {
        [list removeAllObjects];
    }
    Member_commentListsRequest *request = [Member_commentListsRequest new];
    request.mid = self.mid;
    request.page = [NSString stringWithFormat:@"%d", page];
    if (self.reply.length>0) {
        request.reply=self.reply;
    }
    [_apiClient doMember_commentLists:request success:^(NSMutableDictionary *data, NSString *url) {
        Member_commentListsResponse *response = [[Member_commentListsResponse new] fromJSON:data];
        if (page==1&&response.data.list.count==0) {
            if (m_emptyView==nil) {
                [self addEmptyView];
            }else{
                [m_emptyView setHidden:NO];
            }
            
        }else{
            [m_emptyView setHidden:YES];
            if (response.data.list.count > 0) {
                [list addObjectsFromArray:response.data.list];
            }
            [m_tableView reloadData];
        }
    }];
}
-(void)addEmptyView
{
    if (m_emptyView==nil) {
        m_emptyView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kMainScreen_Height)];
        [m_emptyView setBackgroundColor:WHITE_COLOR];
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,100, 100)];
        imgView.center=CGPointMake(kMainScreen_Width*0.5, kMainScreen_Height*0.35);
        [imgView setImage:[UIImage imageNamed:@"nocomment"]];
        [m_emptyView addSubview:imgView];
        
        UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width*0.5, 20)];
        lab1.center=CGPointMake(kMainScreen_Width*0.5, CGRectGetMaxY(imgView.frame)+30);
        [lab1 setTextAlignment:NSTextAlignmentCenter];
        if (self.mid==nil) {
            [lab1 setText:@"您还没有评论"];
        }else{
            [lab1 setText:@"暂无评论"];
        }        
        [m_emptyView addSubview:lab1];
        
    }
    [self addSubview:m_emptyView];
}
#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (list.count > 0) {
        if ([self getListItem:section].reply_info.length > 0) {
            return 3;
        }
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CGFloat height = [[self getListItem:indexPath.section].info boundingRectWithSize:CGSizeMake(kMainScreen_Width - 90, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        return (CGFloat) (105+ height);
    }
    if (indexPath.row==1) {
        NSArray *array = [self getListItem:indexPath.section].imgs;
        if (array.count > 0) {
            return (CGFloat) (kCellHeight * 1.5);
        }
    }
    if (indexPath.row == 2) {
        if ([self getListItem:indexPath.section].reply_info.length>0) {
            NSString *string = [NSString stringWithFormat:@"[私厨回复] %@", [self getListItem:indexPath.section].reply_info];
            CGFloat replyHeight = [string boundingRectWithSize:CGSizeMake(kMainScreen_Width * 0.7, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : FONT_DEFAULT13} context:nil].size.height;
            return replyHeight + kCellHeight * 0.75;
        }
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (CGFloat) (kCellHeight * 0.25);
}

#pragma mark tableview datasource

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width, (CGFloat) (kCellHeight * 0.5))];
    [footer setBackgroundColor:[UIColor clearColor]];
    return footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentify = [NSString stringWithFormat:@"Cell%ld%ld",(long)indexPath.section, (long) indexPath.row];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        m_labReply = [[UILabel alloc] init];
        [m_labReply setTextColor:COLOR_MID_GRAY];
        [m_labReply setNumberOfLines:0];
        [m_labReply setFont:FONT_DEFAULT13];
        [cell.contentView addSubview:m_labReply];

        m_labReplyTime = [[UILabel alloc] init];
        [m_labReplyTime setTextColor:COLOR_MID_GRAY];
        [m_labReplyTime setFont:FONT_DEFAULT13];
        [cell.contentView addSubview:m_labReplyTime];
    }
    if (indexPath.row == 0) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:nil options:nil] firstObject];
        m_iconView = (UIImageView *) [cell viewWithTag:100];
        m_iconView.layer.cornerRadius = m_iconView.frame.size.width / 2;
        m_iconView.layer.masksToBounds = YES;
        [m_iconView load:[self getListItem:indexPath.section].user.img];

        m_labName = (UILabel *) [cell viewWithTag:101];
        m_labName.text = [self getListItem:indexPath.section].uname;
        m_labContent = (UILabel *) [cell viewWithTag:102];
        m_labContent.text = [self getListItem:indexPath.section].info;
        m_labTime = (UILabel *) [cell viewWithTag:103];
        m_labTime.text = [self getListItem:indexPath.section].add_time;
        m_labTime.textColor = getUIColor(0x999999);
    }
    if (indexPath.row == 1) {
        cell.contentView.tag = indexPath.section;

        int totalColumns = 5;
        NSArray *array = [self getListItem:indexPath.section].imgs;

        for (int i = 0; i < array.count; i++) {
            int row = i / totalColumns;
            int col = i % totalColumns;
            CGFloat imgX = (CGFloat) (col * (kImgWidth + 10) + kMainScreen_Width * 0.24);
            CGFloat imgY = kIMgHeigth * row + 10 * row;

            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView setFrame:CGRectMake(imgX, imgY, kImgWidth, kIMgHeigth)];
            Member_comment_imgTable *imgTable=[array objectAtIndex:i];
            [imageView load:imgTable.img];
            //[imageView setImage:[UIImage imageNamed:array[i]]];
            imageView.tag = i;
            [cell.contentView addSubview:imageView];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
            [imageView setUserInteractionEnabled:YES];
            [imageView addGestureRecognizer:tapGesture];
        }
    }
    if (indexPath.row == 2) {
        if ([self getListItem:indexPath.section].reply_info.length>0) {
            NSString *string = [NSString stringWithFormat:@"[私厨回复] %@", [self getListItem:indexPath.section].reply_info];
            CGSize Size = [string boundingRectWithSize:CGSizeMake(kMainScreen_Width * 0.7, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : FONT_DEFAULT13} context:nil].size;
            
            [m_labReply setFrame:CGRectMake(kMainScreen_Width * 0.24, 0, kMainScreen_Width * 0.74, Size.height)];
            [m_labReply setText:string];
            
            [m_labReplyTime setFrame:CGRectMake(kMainScreen_Width * 0.24
                                                , Size.height + 8, kMainScreen_Width * 0.7, 15)];
            [m_labReplyTime setText:[self getListItem:indexPath.section].reply_time];
        }else{
            m_labReply.hidden=YES;
            m_labReplyTime.hidden=YES;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 点击图片

- (void)clickImage:(UIGestureRecognizer *)gesture {
    NSLog(@"%ld,%ld", (long) gesture.view.tag, (long) gesture.view.superview.tag);
    NSInteger index = (long) gesture.view.tag;
   
    NSArray *array = [self getListItem:gesture.view.superview.tag].imgs;
    
    NSMutableArray *arrayImage=[NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        Member_comment_imgTable *imgTable=[array objectAtIndex:i];
        [arrayImage addObject:imgTable.img];
    }
   // NSArray *arrayImage = m_imgArray[(NSUInteger) gesture.view.superview.tag];
    
    UIImageView *imageView = (UIImageView *) gesture.view;
    NSMutableArray *photos = [[NSMutableArray alloc] init];

    for (int i = 0; i < arrayImage.count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        [photo setUrl:[NSURL URLWithString:arrayImage[i]]];
        [photo setSrcImageView:imageView];
        [photos addObject:photo];
    }
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    [browser setCurrentPhotoIndex:(NSUInteger) (index)];
    [browser setPhotos:photos];
    [browser show];
}

- (Member_commentTable *)getListItem:(NSInteger)index {
    if (list.count == 0) {
        return [Member_commentTable new];
    } else {
        return (Member_commentTable *) list[index];
    }
}
@end
