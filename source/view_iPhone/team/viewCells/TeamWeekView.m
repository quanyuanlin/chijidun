//
//  TeamWeekView.m
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import "TeamWeekView.h"

@interface TeamWeekView ()
{
    NSMutableArray *m_arrayLabs;
    NSMutableArray *m_arrayBtns;
    
    
    UISwipeGestureRecognizer *_leftSwipeGesture;
    UISwipeGestureRecognizer *_rightSwipeGesture;
    
    UIScrollView *m_headerView;
}
@end
@implementation TeamWeekView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    
    }
    return self;
}
-(void)addMainView
{
    _currentPage=1;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    m_arrayBtns=[NSMutableArray array];
    m_headerView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 15, kMainScreen_Width, 35)];
    //[m_headerView setContentSize:CGSizeMake(kMainScreen_Width*3, 35)];
    m_headerView.showsHorizontalScrollIndicator=NO;
    CGFloat width=kMainScreen_Width/self.lists.count;
    
    for (int i=0; i<self.lists.count; i++) {
        OrderTimeIntervalTable *item=self.lists[i];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(width*i, 0, width, 15)];
        if (item.disable.intValue==0) {
            [label setTextColor:getUIColor(0x333333)];
        }else if (item.disable.intValue==1){
            [label setTextColor:getUIColor(0xcccccc)];
        }
        [label setFont:[UIFont LightFontOfSize:15]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:item.week];
        [self addSubview:label];
        
        DateButton *dateBtn=[[DateButton alloc]initWithFrame:CGRectMake(width*i, 0, width, 35)];
        dateBtn.tag=i;
        [dateBtn dateButtonSetTitle:item];
        [dateBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([_date isEqualToString:item.date]) {
            dateBtn.selected=YES;
        }
        [m_headerView addSubview:dateBtn];
        [m_arrayBtns addObject:dateBtn];
    }
    [self addSubview:m_headerView];
    
    _leftSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
    _rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    _leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    _rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    _leftSwipeGesture.delegate=self;
    _rightSwipeGesture.delegate=self;
    
    
    if (_hasRight) {
        [m_headerView addGestureRecognizer:_leftSwipeGesture];
    }
    if (_hasLeft) {
        [m_headerView addGestureRecognizer:_rightSwipeGesture];
    }
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type =kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [[m_headerView layer] addAnimation:animation forKey:@"animation"];
        if (self.swipeBlock) {
            self.swipeBlock(YES);
        }
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type =kCATransitionPush;
        animation.subtype = kCATransitionFromLeft;
        [[m_headerView layer] addAnimation:animation forKey:@"animation"];
        if (self.swipeBlock) {
            self.swipeBlock(NO);
        }
    }
}

-(void)reloadDatas
{
    
}
-(void)btnClicked:(DateButton *)button
{
    for (NSInteger i = 0; i < m_arrayBtns.count; i ++) {
        DateButton *btn=m_arrayBtns[i];
        if (i == button.tag) {
            [btn setSelected:YES];
            if (self.indexBlock) {
                self.indexBlock(_lists[button.tag]);
            }
        }else{
            [btn setSelected:NO];
        }
    }
}

@end









