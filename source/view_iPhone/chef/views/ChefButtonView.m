#import "ChefButtonView.h"
@interface ChefButtonView () {
    UIButton *m_btnToday;
    UIButton *m_btnTomorrow;
    CAShapeLayer *lineShape;
    CGFloat BtnWidth;
}
@end

@implementation ChefButtonView
@synthesize p_chefButtonDelegate = m_chefButtonDelegate;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = getUIColor(0xf8f8f8);
        [self addButton];

    }
    return self;
}

- (void)addButton {

    BtnWidth=kMainScreen_Width*0.5-10;
    m_btnToday = [[UIButton alloc] initWithFrame:CGRectMake(kDistanceMin, 0, BtnWidth, kCellHeight)];
    [m_btnToday setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    [m_btnToday setTitle:@"今日供应" forState:UIControlStateNormal];
    [m_btnToday.titleLabel setFont:[UIFont LightFontOfSize:17]];
    [m_btnToday addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];

    m_btnTomorrow = [[UIButton alloc] initWithFrame:CGRectMake((CGFloat) (kMainScreen_Width * 0.5), 0, BtnWidth, kCellHeight)];
    [m_btnTomorrow.titleLabel setFont:[UIFont LightFontOfSize:17]];
    [m_btnTomorrow setBackgroundColor:getUIColor(0xf2f2f2)];
    [m_btnTomorrow setTitle:@"明日预定" forState:UIControlStateNormal];
    [m_btnTomorrow setTitleColor:COLOR_MID_GRAY forState:UIControlStateNormal];
    [m_btnTomorrow addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:m_btnToday];
    [self addSubview:m_btnTomorrow];
    
}
-(void)changeWith:(NSString *)date
{
    if ([date isEqualToString:getToday()]) {
        [self addIndicatorViewWith:(int) (kMainScreen_Width * 0.5) With:(int) kMainScreen_Width-10 With:0 With:0];
        [self addIndicatorViewWith:(int) (kMainScreen_Width * 0.5) With:(int) kMainScreen_Width-10 With:kCellHeight-1 With:kCellHeight-1];
        [m_btnToday setBackgroundColor:YELLOW_COLOR];
        [m_btnToday setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        
        [m_btnTomorrow setBackgroundColor:WHITE_COLOR];
        [m_btnTomorrow setTitleColor:COLOR_DEEP_GRAY forState:UIControlStateNormal];
    }else{
        [self addIndicatorViewWith:kDistance With:(int) (kMainScreen_Width * 0.5) With:kCellHeight-1 With:kCellHeight-1];
        [self addIndicatorViewWith:kDistance With:(int) (kMainScreen_Width * 0.5) With:0 With:0];
        
        [m_btnTomorrow setBackgroundColor:YELLOW_COLOR];
        [m_btnTomorrow setTitleColor:WHITE_COLOR forState:UIControlStateNormal];
        
        [m_btnToday setBackgroundColor:WHITE_COLOR];
        [m_btnToday setTitleColor:COLOR_DEEP_GRAY forState:UIControlStateNormal];
    }
 
}
- (void)selectDate:(UIButton *)btn {
    BOOL isTomottow;
    if (btn==m_btnTomorrow) {
        isTomottow=YES;
    }else{
        isTomottow=NO;
    }
    if ([m_chefButtonDelegate respondsToSelector:@selector(ClickTodayOrTommorrowWith:)]) {
        [m_chefButtonDelegate ClickTodayOrTommorrowWith:isTomottow];
    }
}

- (void)addIndicatorViewWith:(int)x With:(int)toX With:(int)y With:(int)toY{
    if (lineShape != nil) {
        //[lineShape removeFromSuperlayer];
    }
    lineShape = nil;
    CGMutablePathRef linePath = nil;
    linePath = CGPathCreateMutable();
    lineShape = [CAShapeLayer layer];
    lineShape.lineWidth = 0.5f;
    lineShape.lineCap = kCALineCapRound;;
    lineShape.strokeColor = BORDER_COLOR.CGColor;
    CGPathMoveToPoint(linePath, NULL, x, y);
    CGPathAddLineToPoint(linePath, NULL, toX, toY);
    lineShape.path = linePath;
    CGPathRelease(linePath);
    [self.layer addSublayer:lineShape];
}
@end
