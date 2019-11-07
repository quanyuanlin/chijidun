//
//  TeamFoodView.m
//  chijidun
//
//  Created by iMac on 16/9/24.
//
//

#import "TeamFoodView.h"

@interface TeamFoodView ()
{
    UILabel *m_labFood;
    UILabel *m_labNum;
    UILabel *m_labPrice;
}
@end
@implementation TeamFoodView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addMainView];
    }
    return self;
}
-(void)addMainView
{
    CGSize sizeCell=self.frame.size;
    
    m_labFood=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, sizeCell.height)];
    [m_labFood setFont:[UIFont LightFontOfSize:15]];
    [m_labFood setText:@"红烧排骨套餐"];
    [self addSubview:m_labFood];
    
    m_labPrice=[[UILabel alloc]initWithFrame:CGRectMake(sizeCell.width-kDistance-50, 0, 50, sizeCell.height)];
    [m_labPrice setTextColor:getUIColor(0xff5436)];
    [m_labPrice setFont:[UIFont LightFontOfSize:15]];
    [m_labPrice setTextAlignment:NSTextAlignmentRight];
    [m_labPrice setText:@"￥30"];
    [self addSubview:m_labPrice];
    
    m_labNum=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(m_labPrice.frame)-kDistance-50, 0, 50, sizeCell.height)];
    [m_labNum setTextColor:getUIColor(0x333333)];
    [m_labNum setFont:[UIFont LightFontOfSize:15]];
    [m_labNum setTextAlignment:NSTextAlignmentRight];
    [m_labNum setText:@"×2"];
    [self addSubview:m_labNum];
    
//    [self.layer addSublayer:getLine(0, sizeCell.width, sizeCell.height, sizeCell.height, getUIColor(0xdddddd))];
}



@end
