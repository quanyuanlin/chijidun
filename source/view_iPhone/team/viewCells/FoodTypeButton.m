//
//  FoodTypeButton.m
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import "FoodTypeButton.h"

@interface FoodTypeButton ()
{
    UILabel *m_labTilte;
    UIView *m_inditorView;
}
@end
@implementation FoodTypeButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addMainView];
    }
    return self;
}
-(void)addMainView
{
    CGSize sizeBtn=self.frame.size;
    m_labTilte=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, sizeBtn.width, sizeBtn.height)];
    [m_labTilte setTextAlignment:NSTextAlignmentCenter];
    [m_labTilte setFont:[UIFont LightFontOfSize:16]];
    [m_labTilte setNumberOfLines:0];
    [self addSubview:m_labTilte];
    
    m_inditorView=[[UIView alloc]initWithFrame:CGRectMake(0, sizeBtn.height-2.0f, sizeBtn.width, 2.0f)];
    [m_inditorView setBackgroundColor:YELLOW_COLOR];
    [self addSubview:m_inditorView];
    [m_inditorView setHidden:YES];

}
-(void)setTitle:(NSString *)title
{
    [m_labTilte setText:title];
    if (_isLeft) {
       [m_inditorView setFrame:CGRectMake(0, 0, 2.0f, H(self))];
    }
}
-(void)setSelected:(BOOL)selected
{
    if (selected) {
        [m_labTilte setTextColor:YELLOW_COLOR];
        [m_inditorView setHidden:NO];
        if (_isLeft) {
            [self setBackgroundColor:WHITE_COLOR];
        }
    }else{
        [m_labTilte setTextColor:getUIColor(0x333333)];
        [m_inditorView setHidden:YES];
        if (_isLeft) {
            [self setBackgroundColor:[UIColor clearColor]];
        }
    }
}

@end






