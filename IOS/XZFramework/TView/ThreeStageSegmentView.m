//
//  ThreeStageSegmentView.m
//  btc
//
//  Created by txj on 15/1/30.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "ThreeStageSegmentView.h"
#define INDICATOR_MARGIN_LEFT 5



@implementation ThreeStageSegmentView
{
    NSMutableArray *buttons;
    NSMutableArray *buttonsName;
    CGFloat btnwidth;
    BOOL isShowIndicator;
}
-(id)initWithButtonsName:(NSArray *)btnsName frame:(CGRect)frame
{
    isShowIndicator=YES;
    buttonsName=[[NSMutableArray alloc] initWithArray:btnsName];
    buttons = [[NSMutableArray alloc] initWithCapacity:btnsName.count];
    self=[self initWithFrame:frame];
    return self;
}
-(id)initWithOutIndicatorView:(CGRect)frame
{
    isShowIndicator=NO;
    self=[self initWithFrame:frame];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
//    if (isShowIndicator==nil) {
//        isShowIndicator=YES;
//    }
    self= [super initWithFrame:frame];
    if(self){
        if (buttonsName.count==0) {
            buttonsName=[[NSMutableArray alloc] initWithArray:@[@"综合",@"销量",@"价格",@"新品"]];
             buttons = [[NSMutableArray alloc] initWithCapacity:4];
        }
        btnwidth=frame.size.width/buttonsName.count;
        TConfig *config = [TConfig shared];
        
     
        self.normalColor = [UIColor colorWithRed:83/255.0  green:83/255.0
                                            blue:83/255.0  alpha:1];
        self.spliteColor=config.APP_SPLITE_COLOR;
        self.highlightColor = config.APP_MAIN_COLOR;
        if (isShowIndicator) {
            
        
//        CGFloat btnwidth=BUTTON_WIDTH;
        
        self.indicatorView = [[UIView alloc]
                              initWithFrame:CGRectMake(INDICATOR_MARGIN_LEFT, frame.size.height-2, btnwidth-INDICATOR_MARGIN_LEFT*2, 3)];
        self.indicatorView.backgroundColor = self.highlightColor;
        [self addSubview:self.indicatorView];
        }
        NSInteger i=0;
        for (NSString *btnName in buttonsName) {
            UIButton  *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(btnwidth*i, 0, btnwidth, frame.size.height);
            btn.backgroundColor = [UIColor clearColor];
            [btn  setTitle:btnName forState:UIControlStateNormal];
            [btn  addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=i;
            if(i>0)
                [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
            else
                [btn setTitleColor:self.highlightColor forState:UIControlStateNormal];
            [self addSubview:btn];
            [buttons addObject:btn];
            i++;
        }
//
//        
//        self.lowButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        self.lowButton.frame = CGRectMake(0, 0, btnwidth, frame.size.height);
//        self.lowButton.backgroundColor = [UIColor clearColor];
//        [self.lowButton  setTitle:buttonsName[0] forState:UIControlStateNormal];
////        self.lowButton.adjustsImageWhenHighlighted = NO;
////        self.lowButton.adjustsImageWhenDisabled = NO;
////        self.lowButton.showsTouchWhenHighlighted = YES;
//        [self.lowButton  addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
//        self.lowButton.tag=0;
////        [self.lowButton setTitleColor:self.normalColor
////                     forState:UIControlStateNormal];
//        [self addSubview:self.lowButton];
//        
//        
//        self.highButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        self.highButton.frame = CGRectMake(btnwidth, 0, btnwidth, frame.size.height);
//        self.highButton.backgroundColor = [UIColor clearColor];
//        [self.highButton  setTitle:buttonsName[1] forState:UIControlStateNormal];
//        self.highButton .adjustsImageWhenHighlighted = NO;
//        self.highButton .adjustsImageWhenDisabled = NO;
//        self.highButton .showsTouchWhenHighlighted = YES;
//        [self.highButton  addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
//        self.highButton.tag=1;
//        [self.highButton setTitleColor:self.normalColor
//                             forState:UIControlStateNormal];
//
//        [self addSubview:self.highButton];
//        
//        self.priceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        self.priceButton.frame = CGRectMake(btnwidth*2, 0, btnwidth, frame.size.height);
//        self.priceButton.backgroundColor = [UIColor clearColor];
//        [self.priceButton  setTitle:buttonsName[2] forState:UIControlStateNormal];
//        self.priceButton .adjustsImageWhenHighlighted = NO;
//        self.priceButton .adjustsImageWhenDisabled = NO;
//        self.priceButton .showsTouchWhenHighlighted = YES;
//        [self.priceButton  addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
//        self.priceButton.tag=2;
//        [self.priceButton setTitleColor:self.normalColor
//                             forState:UIControlStateNormal];
//        [self addSubview:self.priceButton];
//        
//        
//        self.newsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        self.newsButton.tag=3;
//        //    能够定义的button类型有以下6种，
//        //    typedef enum {
//        //        UIButtonTypeCustom = 0,          自定义风格
//        //        UIButtonTypeRoundedRect,         圆角矩形
//        //        UIButtonTypeDetailDisclosure,    蓝色小箭头按钮，主要做详细说明用
//        //        UIButtonTypeInfoLight,           亮色感叹号
//        //        UIButtonTypeInfoDark,            暗色感叹号
//        //        UIButtonTypeContactAdd,          十字加号按钮
//        //    } UIButtonType;
//        
//        //给定button在view上的位置
//        self.newsButton.frame = CGRectMake(btnwidth*3, 0, btnwidth, frame.size.height);        //button背景色
//        self.newsButton.backgroundColor = [UIColor clearColor];
//        
//        //设置button填充图片
//        //[button1 setImage:[UIImage imageNamed:@"btng.png"] forState:UIControlStateNormal];
//        
//        //设置button标题
//        [self.newsButton  setTitle:@"新品上市" forState:UIControlStateNormal];
//        
//        /* forState: 这个参数的作用是定义按钮的文字或图片在何种状态下才会显现*/
//        //以下是几种状态
//        //    enum {
//        //        UIControlStateNormal       = 0,         常规状态显现
//        //        UIControlStateHighlighted  = 1 << 0,    高亮状态显现
//        //        UIControlStateDisabled     = 1 << 1,    禁用的状态才会显现
//        //        UIControlStateSelected     = 1 << 2,    选中状态
//        //        UIControlStateApplication  = 0x00FF0000, 当应用程序标志时
//        //        UIControlStateReserved     = 0xFF000000  为内部框架预留，可以不管他
//        //    };
//        
//        /*
//         * 默认情况下，当按钮高亮的情况下，图像的颜色会被画深一点，如果这下面的这个属性设置为no，
//         * 那么可以去掉这个功能
//         */
//        self.newsButton .adjustsImageWhenHighlighted = NO;
//        /*跟上面的情况一样，默认情况下，当按钮禁用的时候，图像会被画得深一点，设置NO可以取消设置*/
//        self.newsButton .adjustsImageWhenDisabled = NO;
//        /* 下面的这个属性设置为yes的状态下，按钮按下会发光*/
//        self.newsButton .showsTouchWhenHighlighted = YES;
//        
//        /* 给button添加事件，事件有很多种，我会单独开一篇博文介绍它们，下面这个时间的意思是
//         按下按钮，并且手指离开屏幕的时候触发这个事件，跟web中的click事件一样。
//         触发了这个事件以后，执行butClick:这个方法，addTarget:self 的意思是说，这个方法在本类中
//         也可以传入其他类的指针*/
//        [self.newsButton  addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.newsButton setTitleColor:self.normalColor
//                             forState:UIControlStateNormal];
//
//        //显示控件
//        [self addSubview:self.newsButton];
//        
//        
//        buttons = [[NSMutableArray alloc] init];
//        for (UIView *child in self.subviews) {
//            if ([child isKindOfClass:[UIButton class]]) {
//                UIButton *button = (UIButton *)child;
//                [button addTarget:self action:@selector(didTapButton:)
//                 forControlEvents:UIControlEventTouchUpInside];
//                [buttons addObject:child];
//            }
//        }
//        [((UIButton *)[buttons objectAtIndex:0]) setHighlighted:NO];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
 
    CGFloat btnwidth=rect.size.width/buttonsName.count;
    
    CGFloat h=(rect.size.height-30)/2;
    
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();
    //设置粗细
    CGContextSetLineWidth(context,0.2);
    
    //开始绘图
    CGContextBeginPath(context);
    
    if (isShowIndicator) {
        //移动到开始绘图底线
        CGContextMoveToPoint(context, 0, 40);
        CGContextAddLineToPoint(context,self.frame.size.width, 40);
    }
   
    for(int i =0;i<buttonsName.count;i++)
    {
        CGContextMoveToPoint(context, btnwidth*(i+1), h);
        CGContextAddLineToPoint(context,btnwidth*(i+1), h+30);
    }
    
//    //分割线1
//    CGContextMoveToPoint(context, btnwidth, h);
//    CGContextAddLineToPoint(context,btnwidth, h+30);
//    
//    //分割线2
//    CGContextMoveToPoint(context, btnwidth*2, h);
//    CGContextAddLineToPoint(context,btnwidth*2, h+30);
//    
//    //分割线3
//    CGContextMoveToPoint(context, btnwidth*3, h);
//    CGContextAddLineToPoint(context,btnwidth*3, h+30);
    
    //关闭路径
    CGContextClosePath(context);
    
    //设置颜色
    [self.spliteColor setStroke];
    //绘图
    CGContextStrokePath(context);
    
   
    
}


- (void)changeSelectedIndex:(NSInteger)index
{
    for (NSInteger i = 0, size = buttonsName.count; i < size; i++) {
        UIButton *button = (UIButton *)[buttons objectAtIndex:i];
        if (i == index) {
            [button setTitleColor:self.highlightColor
                         forState:UIControlStateNormal];
            
          
            [UIView
             animateWithDuration:0.2 delay:0
             options:UIViewAnimationOptionCurveEaseInOut
             animations:^{
                 CGFloat x = INDICATOR_MARGIN_LEFT+btnwidth*i;
                if (isShowIndicator) { self.indicatorView.frame = CGRectMake(x, self.frame.size.height-3, btnwidth-INDICATOR_MARGIN_LEFT*2, 3);}
             } completion:^(BOOL finished) {
             }];
            
            
        } else {
            [button setTitleColor:self.normalColor
                         forState:UIControlStateNormal];
        }
    }
    self.selectedIndex = index;
    SEL selector = @selector(threeStageSegmentView:didSelectAtIndex:);
    if ([self.delegate respondsToSelector:selector]) {
        [self.delegate threeStageSegmentView:self didSelectAtIndex:index];
    }
}

- (void)didTapButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [self changeSelectedIndex:button.tag];
}

@end
