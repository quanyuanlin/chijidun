//
//  ScoreViewController.m
//  
//
//  Created by iMac on 16/1/4.
//
//

#import "ScoreViewController.h"

@interface ScoreViewController ()
{
    UserTable *m_user;
}
@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"我的积分";
    self.navigationItem.leftBarButtonItem=[self tbarBackButton];
    self.view.backgroundColor=getColorWithRGB(239, 240, 241);
    self.backView.backgroundColor=MAIN_COLOR;
    self.iconView.layer.cornerRadius=40.0f;
    self.iconView.layer.masksToBounds=YES;
    self.iconView.center=CGPointMake(kMainScreen_Width*0.1, 50);    
    
    [self loadUserData];
}
-(void)loadUserData
{
    UserGetRequest *request = [UserGetRequest new];
    [apiClient doUserGet:request success:^(NSMutableDictionary *data, NSString *url) {
        UserGetResponse *response = [[UserGetResponse new] fromJSON:data];
        m_user=response.data;
        [self.iconView load:m_user.img];
        self.nameLabel.text = m_user.username;
        self.scoreLabel.text=m_user.score;
    }];
}
- (IBAction)detailBtnTapped:(id)sender {
    ScoreDetailViewController *detail=[[ScoreDetailViewController alloc]init];
    [self showNavigationView:detail];
}

@end




