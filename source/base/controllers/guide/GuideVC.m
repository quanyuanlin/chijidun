//
//  GuideVC.m
//  JieFangShop2.0
//
//  Created by Apple on 15/4/27.
//  Copyright (c) 2015年 yuanlin. All rights reserved.
//

#import "GuideVC.h"
#import "AppDelegate.h"
#define BTN_WIDTH S(175)
#define BTN_HEIGHT S(35)
@interface GuideVC ()
{
    NSInteger _currentPage;
    UIButton *_button;
    
    NSMutableArray *m_imgArray;
}
@end

@implementation GuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setFirstView];
}
-(void)setFirstView{
    
    CGFloat w = kMainScreen_Width;
    CGFloat h = kMainScreen_Height;
    
    UIScrollView *scrollView=[[UIScrollView alloc]init];
    [scrollView setFrame:self.view.bounds];
    scrollView.delegate=self;
    
    m_imgArray=[NSMutableArray array];
    for (int i=0;i<2 ; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*w, 0, w, h)];
        NSString *imageName=[NSString stringWithFormat:@"guide_%d",i+1];
        
        [imageView setImage:[UIImage imageNamed:imageName]];
        [scrollView addSubview:imageView];
        [m_imgArray addObject:imageView];
        if (i>=2) {
            [imageView click:self action:@selector(tapImage:)];
        }
    }
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.pagingEnabled=YES;
    
    scrollView.clipsToBounds=YES;
    scrollView.bounces=NO;
    
    
    scrollView.contentSize=CGSizeMake(w*2, h);
    scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:scrollView];
    
    
//    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kMainScreen_Height-80, kMainScreen_Width, 20)];
//    self.pageControl.currentPage = 0;
//    self.pageControl.numberOfPages = 3;
//    self.pageControl.pageIndicatorTintColor=WHITE_COLOR;
//    self.pageControl.currentPageIndicatorTintColor=MAIN_COLOR;
//    [self.view addSubview:self.pageControl];
    
    CGFloat btnX=(kMainScreen_Width-BTN_WIDTH)/2;
    _button=[[UIButton alloc]initWithFrame:CGRectMake(btnX, kMainScreen_Height, BTN_WIDTH, BTN_HEIGHT)];
    [_button setImage:[UIImage imageNamed:@"guide_button"] forState:UIControlStateNormal];
    [self.view addSubview:_button];
    [_button addTarget:self action:@selector(tapImage:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    CGFloat btnX=(kMainScreen_Width-BTN_WIDTH)/2;
    CGFloat btnY=kMainScreen_Height-BTN_HEIGHT-S(30);
    
    UIImageView *imgView=m_imgArray[1];
    if (index==1) {
        [UIView animateWithDuration:0.3f animations:^{
            [_button setFrame:CGRectMake(btnX,btnY, BTN_WIDTH, BTN_HEIGHT)];
            [imgView setImage:[UIImage imageNamed:@"guide_nopoint"]];
        }];
    }else{
        [_button setFrame:CGRectMake(btnX,kMainScreen_Height, BTN_WIDTH, BTN_HEIGHT)];
        [imgView setImage:[UIImage imageNamed:@"guide_2"]];
    }
}
-(void)tapImage:(id)sender
{
    if (self.clickBlock) {
        self.clickBlock();
    }
}



@end




