//
//  RemarkButtonView.m
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import "RemarkButtonView.h"

#define kButtonTag 1000
#define ItemH 35
@interface RemarkButtonView ()
{
    NSMutableArray *_buttonArrays;
}
@end
@implementation RemarkButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = WHITE_COLOR;
        [self addSubviews];
        
    }
    return self;
}
-(void)addSubviews
{
    self.layer.cornerRadius=5.0f;
    self.layer.masksToBounds=YES;
    
}
-(void)setButtons:(NSArray *)array
{
    _buttonLists=[NSArray arrayWithArray:array];
    CGFloat itemX=0;
    _buttonArrays=[NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        RemarkTable *item=array[i];
        UIButton *button=[[UIButton alloc]init];
        CGFloat width=getTextSize(item.title, kMainScreen_Width, [UIFont LightFontOfSize:14]).width+2*kDistanceMin;
        [button setFrame:CGRectMake(itemX, 0, width, ItemH)];
        [button setTitle:item.title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont LightFontOfSize:14]];
        [button setTitleColor:TEXT_MIDDLE forState:UIControlStateNormal];
        [button setTitleColor:WHITE_COLOR forState:UIControlStateSelected];
        button.adjustsImageWhenHighlighted=NO;
        if (i>0) {
            [button.layer addSublayer:getLine(0, 0, 0, ItemH, BORDER_COLOR)];
        }
        [button setBackgroundImage:[UIImage imageWithColor:WHITE_COLOR] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:MAIN_COLOR] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=kButtonTag+i;
        for (RemarkTable *remak in _selectArrays) {
            if ([item.rid isEqualToString:remak.rid]) {
                [button setSelected:YES];
            }
        }
        [self addSubview:button];
        itemX=itemX+width;
        [_buttonArrays addObject:button];
    }
    
}
-(void)buttonClicked:(UIButton *)button
{
    for (NSInteger i = 0; i < _buttonArrays.count; i ++) {
        UIButton *btn=_buttonArrays[i];
        if ((i+kButtonTag) == button.tag) {
            if (btn.selected) {
                [btn setSelected:NO];
                if (self.selectBlock) {
                    self.selectBlock(_buttonLists[i],btn.selected);
                }
            }else{
                btn.selected=YES;
                if (self.selectBlock) {
                    self.selectBlock(_buttonLists[i],btn.selected);
                }
            }
        }else{
            if (btn.selected) {
                [btn setSelected:NO];
                if (self.selectBlock) {
                    self.selectBlock(_buttonLists[i],btn.selected);
                }
            }
        }
    }
}

@end
