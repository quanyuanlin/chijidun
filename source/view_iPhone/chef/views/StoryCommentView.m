#import "StoryCommentView.h"

@interface StoryCommentView () {
    UIButton *m_storyBtn;
    UIButton *m_commentBtn;
    CAShapeLayer *lineShape;
}
@end

@implementation StoryCommentView
@synthesize p_storyCommentDelegate = m_storyCommentDelegate;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addButton];
    }
    return self;
}

- (void)addButton {
    [self addIndicatorViewWith:0 With:kMainScreen_Width * 0.5];
    m_storyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kMainScreen_Width * 0.5, kCellHeight)];
    [m_storyBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [m_storyBtn setTitle:@"厨房故事" forState:UIControlStateNormal];
    [m_storyBtn addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];

    m_commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreen_Width * 0.5, 0, kMainScreen_Width * 0.5, kCellHeight)];
    [m_commentBtn setBackgroundColor:BG_COLOR];
    [m_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [m_commentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [m_commentBtn addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:m_storyBtn];
    [self addSubview:m_commentBtn];
}

- (void)pressButton:(UIButton *)btn {
    NSInteger index;
    if (btn == m_storyBtn) {
        index = 1;
        [self addIndicatorViewWith:0 With:kMainScreen_Width * 0.5];
    } else {
        index = 2;
        [self addIndicatorViewWith:kMainScreen_Width * 0.5 With:kMainScreen_Width];
    }
    if ([m_storyCommentDelegate respondsToSelector:@selector(ClickStoryOrCommentWith:)]) {
        [m_storyCommentDelegate ClickStoryOrCommentWith:index];
    }
}

- (void)addIndicatorViewWith:(int)x With:(int)toX {
    if (lineShape != nil) {
        [lineShape removeFromSuperlayer];
    }
    lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = 2.0f;
    lineShape.lineCap = kCALineCapRound;;
    lineShape.strokeColor = [UIColor orangeColor].CGColor;
    int y = kCellHeight - 2;
    int toY = kCellHeight - 2;
    CGPathMoveToPoint(linePath, NULL, x, y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    [self.layer addSublayer:lineShape];
}
@end









