//
//  MyCommentsViewController.m
//  
//
//  Created by iMac on 16/3/4.
//
//

#import "MyCommentsViewController.h"

@interface MyCommentsViewController ()
{
    UIButton *m_btnAll;
    UIButton *m_btnReply;
    UIView *m_indicatorView;
    UILabel *m_labNum;
    
    UITableView *m_tableView;
    CommentDetailView *m_commentView;
}
@end

@implementation MyCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的评价";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    
    [self addMainView];
    
    [self.view setBackgroundColor:getColorWithRGB(240, 240, 240)];
    m_commentView = [[CommentDetailView alloc] initWithFrame:CGRectMake(0, kCellHeight+2, kMainScreen_Width, kMainScreen_Height-64-kCellHeight-2)];
    m_commentView.apiClient = self->apiClient;
    [m_commentView load];
    [self.view addSubview:m_commentView];
    
    [self loadReplyData];
}
-(void)loadReplyData
{
    UserMemberReplyUncheckCountRequest *request = [UserMemberReplyUncheckCountRequest new];
    [apiClient doUserMemberReplyUncheckCount:request success:^(NSMutableDictionary *data, NSString *url) {
        UserMemberReplyUncheckCountResponse *response = [[UserMemberReplyUncheckCountResponse new] fromJSON:data];
        self.replyNum=response.data.count;
        if (self.replyNum.intValue>0) {
            [m_labNum setText:self.replyNum];
        }else{
            [m_labNum setHidden:YES];
        }
    }];
}
-(void)addMainView
{
    UIView *viewHeader=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kCellHeight)];
    [viewHeader setBackgroundColor:WHITE_COLOR];
    [self.view addSubview:viewHeader];
    
    m_btnAll=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width*0.5, kCellHeight)];
    [m_btnAll setTitle:@"全部评价" forState:UIControlStateNormal];
    [m_btnAll setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [m_btnAll setTitleColor:TEXT_COLOR_GRAY forState:UIControlStateNormal];
    [m_btnAll addTarget:self action:@selector(clickBtnWith:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:m_btnAll];
    
    m_btnReply=[[UIButton alloc]initWithFrame:CGRectMake(kMainScreen_Width*0.5, 0, kMainScreen_Width*0.5, kCellHeight)];
    [m_btnReply setTitle:@"私厨回复" forState:UIControlStateNormal];
    [m_btnReply setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [m_btnReply setTitleColor:TEXT_COLOR_GRAY forState:UIControlStateNormal];
    [m_btnReply addTarget:self action:@selector(clickBtnWith:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:m_btnReply];
    
    CGFloat btnWidth=m_btnReply.frame.size.width;
    CGFloat labWidth=18.0f;
    m_labNum=[[UILabel alloc]initWithFrame:CGRectMake(btnWidth*0.7, 5, labWidth, labWidth)];
    m_labNum.layer.cornerRadius=labWidth/2;
    m_labNum.layer.masksToBounds=YES;
    [m_labNum setBackgroundColor:[UIColor redColor]];
    [m_labNum setTextColor:WHITE_COLOR];
    [m_labNum setFont:FONT_DEFAULT15];
    [m_labNum setTextAlignment:NSTextAlignmentCenter];
    [m_btnReply addSubview:m_labNum];
    if (self.replyNum.intValue>0) {
        [m_labNum setText:self.replyNum];
    }else{
        [m_labNum setHidden:YES];
    }
    
    [m_btnAll setSelected:YES];
    m_indicatorView=[[UIView alloc]init];
    [m_indicatorView setFrame:CGRectMake(0, 0, 80, 2)];
    m_indicatorView.center=CGPointMake(kMainScreen_Width*0.25, 39);
    [m_indicatorView setBackgroundColor:MAIN_COLOR];
    [viewHeader addSubview:m_indicatorView];
    
}
-(void)clickBtnWith:(UIButton *)button
{
    if (button==m_btnAll) {
        [m_btnReply setSelected:NO];
        [m_btnAll setSelected:YES];
        [m_indicatorView setCenter:CGPointMake(kMainScreen_Width*0.25, 39)];
        [m_commentView refreshWith:@""];
    }else{
        [m_btnReply setSelected:YES];
        [m_btnAll setSelected:NO];
        [m_indicatorView setCenter:CGPointMake(kMainScreen_Width*0.75, 39)];
        [m_commentView refreshWith:@"reply"];
    }
    [self loadReplyData];
}

@end






