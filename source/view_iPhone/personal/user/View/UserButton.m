//
//  UserButton.m
//  chijidun
//
//  Created by iMac on 16/12/23.
//
//

#import "UserButton.h"

@interface UserButton()
{
    UILabel *m_labTitle;
    UILabel *m_labNum;
}
@end
@implementation UserButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviewsWith:frame];
    }
    return self;
}
-(void)addSubviewsWith:(CGRect)frame
{
    CGSize sizeBtn=frame.size;
    m_labNum=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, sizeBtn.width, 25)];
    [m_labNum setTextColor:WHITE_COLOR];
    [m_labNum setFont:[UIFont BoldFontOfSize:18]];
    [m_labNum setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:m_labNum];
    
    m_labTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(m_labNum.frame)+5, sizeBtn.width, 20)];
    [m_labTitle setTextColor:WHITE_COLOR];
    [m_labTitle setFont:[UIFont LightFontOfSize:15]];
    [m_labTitle setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:m_labTitle];
}
-(void)setDataWith:(NSString *)title and:(NSString *)num
{
    [m_labTitle setText:title];
    [m_labNum setText:num];
}


@end
