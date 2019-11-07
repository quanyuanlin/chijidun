#import "CommentDetailVC.h"

@interface CommentDetailVC () {
    CommentDetailView *m_commentView;
}
@end

@implementation CommentDetailVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"评论";
    if (self.mid.length==0) {
        self.title = @"我的评价";
    }
    self.navigationItem.leftBarButtonItem = [self tbarBackButton];

    m_commentView = [[CommentDetailView alloc] init];
    m_commentView.apiClient = self->apiClient;
    m_commentView.mid=self.mid;
    [m_commentView load];
    self.view = m_commentView;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


@end
