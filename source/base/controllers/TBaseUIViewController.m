#import <ShareSDK/ShareSDK.h>
#import <AVFoundation/AVFoundation.h>
#import <UMMobClick/MobClick.h>
#import "ApiClient.h"

@implementation UIView (FindFirstResponder)

- (UIView *)findFirstResponder {
    if (self.isFirstResponder) return self;
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) return firstResponder;
    }
    return nil;
}

@end

@interface TBaseUIViewController ()
{
    CGFloat _maxY;
}
@end

@implementation TBaseUIViewController

- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [MobClick beginLogPageView:[[self class] description]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[[self class] description]];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    progressbar = [[MBProgressHUD alloc] initWithView:self.view];
    progressbar.dimBackground = NO;
    progressbar.labelFont=[UIFont LightFontOfSize:15];
    progressbar.labelText = @"正在加载...";
    [self.navigationController.view addSubview:progressbar];
    
    [[App shared] readDeviceToken];
    self->apiClient = [[ApiClient alloc]
            init:^(NSMutableDictionary *data, NSString *url, BOOL hideProgress) {
                if (hideProgress) {
                    [progressbar hide:YES];
                } else {
                    [progressbar show:YES];
                }
            }
    afterRequest:^(NSMutableDictionary *data, NSString *url) {
        [progressbar hide:YES];
        if ([data[@"status"] intValue] == 0) {
            [self.view showHUD:data[@"result"]];
        }
        
        if ([data[@"status"] intValue]==201) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self presentVC:[LoginViewController new]];
            });
        }
    }
        getToken:^NSString * {
            return [App shared].currentUser.token;
        }
       getApiUrl:^NSString * {
           return [NSString stringWithFormat:@"%@/", API_URL];
       }];
    
    
    self->cgClient = [[CGClient alloc]
                      init:^(CGRequest *data, NSString *url, BOOL hideProgress) {
                          if (hideProgress) {
                              [progressbar hide:YES];
                          } else {
                              [progressbar show:YES];
                          }
                      }
                      afterRequest:^(CGResponse *data, NSString *url) {
                          [progressbar hide:YES];
                          if ([data.status intValue] == 0) {
                              if (![data.result isEqualToString:@"您输入的账号或者密码有误"]) {
                                  [self.view showHUD:data.result];
                              }
                          }
                          if ([data.code intValue]==1000||[data.status intValue]==201) {
                              [self.view showHUD:data.result];
                              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                  [self presentVC:[LoginViewController new]];
                              });
                          }
                      }
                      getToken:^NSString * {
                          return [App shared].currentUser.token;
                      }
                      getApiUrl:^NSString * {
                          return [NSString stringWithFormat:@"%@/", API_URL];
                      }];

    ISIOS7PLUS = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7;
    if (ISIOS7PLUS) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    ISIPHONE6 = [UIScreen mainScreen].bounds.size.width > 750;
    screenSize = self.navigationController.view.frame.size;
    
    
    MJRefreshGifHeader *gifheader = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDatas:)];
    NSMutableArray *images=[NSMutableArray array];
    for (int i=0; i<4; i++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"refresh_%d",i]];
        [images addObject:image];
    }
    [gifheader setImages:images forState:MJRefreshStateIdle];
    [gifheader setImages:images forState:MJRefreshStatePulling];
    [gifheader setImages:images forState:MJRefreshStateRefreshing];
    [gifheader setTitle:@"小锅小灶，家里味道" forState:MJRefreshStateIdle];
    [gifheader setTitle:@"小锅小灶，家里味道" forState:MJRefreshStatePulling];
    [gifheader setTitle:@"小锅小灶，家里味道" forState:MJRefreshStateRefreshing];
    gifheader.lastUpdatedTimeLabel.hidden = YES;
    gifheader.stateLabel.font = [UIFont LightFontOfSize:11];
    gifheader.stateLabel.textColor=TEXT_LIGHT;
    refresh_header=gifheader;
    
    
    MJRefreshGifHeader *gifheader1 = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDatas:)];
    [gifheader1 setImages:images forState:MJRefreshStateIdle];
    [gifheader1 setImages:images forState:MJRefreshStatePulling];
    [gifheader1 setImages:images forState:MJRefreshStateRefreshing];
    [gifheader1 setTitle:@"释放即可刷新" forState:MJRefreshStateIdle];
    [gifheader1 setTitle:@"释放即可刷新" forState:MJRefreshStatePulling];
    [gifheader1 setTitle:@"努力刷新中" forState:MJRefreshStateRefreshing];
    gifheader1.lastUpdatedTimeLabel.hidden = YES;
    gifheader1.stateLabel.font = [UIFont LightFontOfSize:11];
    gifheader1.stateLabel.textColor=TEXT_LIGHT;
    refresh_header1=gifheader1;
}
-(void)refreshDatas:(id)sender
{
    if (self.refreshBlock) {
        self.refreshBlock();
    }
}
- (UIToolbar *)createToolbar {
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(nextTextField)];

    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Prev"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(prevTextField)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(textFieldDone)];
    toolBar.items = @[prevButton, nextButton, space, done];
    return toolBar;
}

- (UIView *)tToolbarSearchField:(CGFloat)width withheight:(CGFloat)height isbecomeFirstResponder:(BOOL)becomeFirstResponder action:(SEL)fun textFieldDelegate:(id <UITextFieldDelegate>)fdelegate {
    CGFloat searchfieldHeight = 32;
    UIView *searchFieldView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    UIView *searchField = [[UIView alloc] initWithFrame:CGRectMake(0, (height - searchfieldHeight) / 2, ISIPHONE6 ? width : width - 20, searchfieldHeight)];
    searchField.backgroundColor = WHITE_COLOR;
    searchField.layer.cornerRadius = 5;

    CGSize iconTextSize = [self getSizeForText:@"\U0000B25A" havingWidth:MAXFLOAT havingHeight:MAXFLOAT andFont:[UIFont fontWithName:@"iconfont" size:22]];
    UILabel *label = [self tIconLable:@"\U0000B07A" withFrame:CGRectMake(8, (searchfieldHeight - iconTextSize.height) / 2, iconTextSize.width, iconTextSize.height) fontSize:22 fontColor:TEXT_COLOR_DARK];

    [searchField addSubview:label];

    UITextField *search = [[UITextField alloc] initWithFrame:CGRectMake(40, (searchField.frame.size.height - 20) / 2, searchField.frame.size.width - label.frame.size.width, 25)];
    search.placeholder = NSLocalizedString(@"SearchTips", @"");
    if (fun) {
        [search addTarget:self action:fun forControlEvents:UIControlEventTouchDown];
    }
    search.font = [UIFont systemFontOfSize:14];
    //search.backgroundColor=[UIColor blackColor];
    search.returnKeyType = UIReturnKeySearch;
    search.textColor = TEXT_COLOR_DARK;
    if (becomeFirstResponder) {
        [search becomeFirstResponder];
    }
    search.delegate = fdelegate;
    [searchField addSubview:search];
    [searchFieldView addSubview:searchField];

    [self addListener:searchFieldView action:fun];

    return searchFieldView;
}

- (UIBarButtonItem *)tbarBackButton {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(-10, 0, 44, 44);
    [backBtn setTitle:@"\U0000A07A" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:18];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setTitleColor:TEXT_COLOR_BLACK forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    return backItem;
}

- (UIBarButtonItem *)tbarBackButtonWhite {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(-10, 0, 44, 44);
    [backBtn setTitle:@"\U0000A07A" forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:18];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    return backItem;
}

- (UIBarButtonItem *)tBarButtonItem:(NSString *)text action:(SEL)selctor {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 80, 40);
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setTitle:text forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:selctor forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    return backItem;
}

- (UIBarButtonItem *)tBarIconButtonItem:(NSString *)text action:(SEL)selctor {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 30, 30);
    //backBtn.backgroundColor=[UIColor blackColor];
    [backBtn setTitle:text forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:25];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:selctor forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    return backItem;
}

- (void)addListener:(UIView *)view action:(SEL)fun {
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:fun];
    [view addGestureRecognizer:tapGesture];
}

- (UILabel *)tIconLable:(NSString *)iconcode withFrame:(CGRect)frame fontSize:(CGFloat)fsize fontColor:(UIColor *)fcolor {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont fontWithName:@"iconfont" size:fsize];
    label.text = iconcode;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = fcolor;
    return label;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (CGSize)getSizeForText:(NSString *)text havingWidth:(CGFloat)widthValue havingHeight:(CGFloat)heightValue andFont:(UIFont *)font {
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        return [text boundingRectWithSize:CGSizeMake(widthValue, heightValue)
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{
                                       NSFontAttributeName : font,
                                       NSForegroundColorAttributeName : [UIColor blackColor],
                               }
                                  context:nil].size;
    }
    else {
        return [text sizeWithFont:font
                constrainedToSize:CGSizeMake(widthValue, heightValue)];
    }
}

- (void)nextTextField {

    NSUInteger currentIndex = [[self inputViews] indexOfObject:[self.view findFirstResponder]];

    NSUInteger nextIndex = currentIndex + 1;
    nextIndex += [[self inputViews] count];
    nextIndex %= [[self inputViews] count];

    UITextField *nextTextField = [self inputViews][nextIndex];

    [nextTextField becomeFirstResponder];

}

- (void)prevTextField {

    NSUInteger currentIndex = [[self inputViews] indexOfObject:[self.view findFirstResponder]];
    NSUInteger prevIndex = currentIndex - 1;
    prevIndex += [[self inputViews] count];
    prevIndex %= [[self inputViews] count];
    UITextField *nextTextField = [self inputViews][prevIndex];
    [nextTextField becomeFirstResponder];
}

- (NSArray *)inputViews {
    NSMutableArray *returnArray = [NSMutableArray array];
    for (UIView *eachView in self.view.subviews) {
        if ([eachView respondsToSelector:@selector(setText:)]) {
            [returnArray addObject:eachView];
        }
    }
    return returnArray;
}

- (void)textFieldDone {
    [[self.view findFirstResponder] resignFirstResponder];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)presentVC:(UIViewController *)controller
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3; 
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"pageCurl";
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:controller animated:NO completion:nil];
}
- (void)showNavigationView:(UIViewController *)controller {
    UDNavigationController *navigationController = [[UDNavigationController alloc]initWithRootViewController:controller];
    navigationController.alphaView.backgroundColor = NAVI_COLOR;
    NSDictionary *dict = @{NSForegroundColorAttributeName : TEXT_DEEP,
                           NSFontAttributeName : [UIFont LightFontOfSize:18]};
    navigationController.navigationBar.titleTextAttributes = dict;
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.8f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:@"animation"];
    
    [self presentViewController:navigationController animated:NO completion:^{
    }];
}

- (void)showNavigationViewMainColor:(UIViewController *)controller {
    UDNavigationController *thirdNavigationController = [[UDNavigationController alloc]
            initWithRootViewController:controller];
    [self presentViewController:thirdNavigationController animated:NO completion:^{
    }];
}

- (void)goBack {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.8f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:@"animation"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void (^)(RACTuple *))didUpdate:(NSString *)text {
    @weakify(self)
    return ^(RACTuple *parameters) {
        @strongify(self)
        ResponseResult *rs = (ResponseResult *) parameters;
        if (rs.success) {
            [self.view showHUD:text];
        }
        else {
            [self.view showHUD:rs.messge];
        }
    };
}

- (void (^)(RACTuple *))didUpdate:(NSString *)text withTableView:(UITableView *)tableview {
    @weakify(self)
    return ^(RACTuple *parameters) {
        @strongify(self)
        ResponseResult *rs = (ResponseResult *) parameters;
        if (rs.success) {
            [self.view showHUD:text];
            [tableview reloadData];
        }
        else {
            [self.view showHUD:rs.messge];
        }
        [self dismissViewControllerAnimated:YES completion:nil];

    };
}

-(void)showErrorWith:(CGRect)frame Title:(NSString *)title
{
    if (m_errorView==nil) {
        m_errorView=[[UIImageView alloc]initWithFrame:frame];
        [m_errorView setImage:[UIImage imageNamed:@"login_error"]];
        m_labError=[[UILabel alloc]initWithFrame:CGRectMake(S(10), 0, W(m_errorView)-S(20), S(28))];
        [m_labError setFont:[UIFont systemFontOfSize:S(15)]];
        [m_labError setTextColor:WHITE_COLOR];
        [m_errorView addSubview:m_labError];
        [self.view addSubview:m_errorView];
    }
    [m_labError setText:title];
    [m_errorView setHidden:NO];
}
-(void)hideErrorView
{
    [m_errorView setHidden:YES];
}
- (UIView *)findFirstResponderForView:(UIView *)view
{
    if (view.isFirstResponder) {
        return view;
    }
    if (view.subviews.count > 0) {
        
        for (UIView *obj in view.subviews) {
            UIView *firstResponder = [self findFirstResponderForView:obj];
            if (firstResponder != nil) {
                return firstResponder;
            }
        }
    }
    
    return nil;
}

- (void)addKeyboardNote:(CGFloat)maxY
{
    _maxY=maxY;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)note
{
    CGFloat keyboardH = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat keyboardY = self.view.frame.size.height - keyboardH;
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (duration <= 0.0) {
        duration = 0.25;
    }
    [UIView animateWithDuration:duration animations:^{
        if (_maxY > keyboardY) {
            self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - _maxY - 5);
        } else {
            self.view.transform = CGAffineTransformIdentity;
        }
    }];
}
#pragma mark 隐藏键盘就会调用
- (void)keyboardWillHide:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

@end









