//
//  HomeDescView.m
//  chijidun
//
//  Created by iMac on 16/12/2.
//
//

#import "HomeDescView.h"
#define kImageHeight 14

@interface HomeDescView ()
{
    UIImageView *m_imgView;
    UILabel     *m_labTitle;
}
@end
@implementation HomeDescView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addMainViewWith:frame];
    }
    return self;
}
-(void)addMainViewWith:(CGRect)frame
{
    m_imgView=[[UIImageView alloc]initWithFrame:CGRectMake(kDistanceMin, 0, kImageHeight, kImageHeight)];
    [self addSubview:m_imgView];
    
    CGFloat width=frame.size.width-40;
    m_labTitle=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, width, kImageHeight)];
    [m_labTitle setTextColor:TEXT_MIDDLE];
    [m_labTitle setFont:[UIFont LightFontOfSize:13]];
    [self addSubview:m_labTitle];
}

-(void)setImageWith:(NSString *)image Title:(NSString *)title
{
    CGSize size=[UIImage imageNamed:image].size;
    [m_imgView setFrame:CGRectMake(kDistanceMin, 0, size.width/2, kImageHeight)];
    CGFloat width=self.frame.size.width-size.width/2-5;
    if (_isHome) {
        if (iPhone4||iPhone5) {
            width=MIN(width, 75);
        }else{
            width=MIN(width, 85);
        }
    }
    [m_labTitle setFrame:CGRectMake(CGRectGetMaxX(m_imgView.frame)+5, 0, width, kImageHeight)];
    
    [m_imgView setImage:[UIImage imageNamed:image]];
    [m_labTitle setText:title];
}

@end
