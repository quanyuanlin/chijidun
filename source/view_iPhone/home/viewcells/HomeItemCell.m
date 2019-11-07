//
//  HomeItemCell.m
//  chijidun
//
//  Created by iMac on 16/12/1.
//
//

#import "HomeItemCell.h"

#define kImageHeight 14
@interface HomeItemCell ()
{
    UIView *m_descView;
    MemberTable *_member;
}
@end
@implementation HomeItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labTitle setFont:[UIFont FontOfSize:18]];
    [self.labStatus setFont:[UIFont LightFontOfSize:15]];
    [self.labTown setFont:[UIFont LightFontOfSize:12]];
    
    self.iconView.layer.cornerRadius=25.0f;
    self.iconView.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)bindWith:(MemberTable *)member
{
    _member=member;
    CGFloat width=kMainScreen_Width-2*kDistanceMin;
    CGFloat height=width*3/5;
    if (self.itemScrollView&&member.hot_items.count>0) {
        self.itemScrollView.showsHorizontalScrollIndicator=NO;
        self.itemScrollView.bounces=NO;
        self.itemScrollView.delegate=self;
        self.itemScrollView.scrollsToTop=NO;
        self.itemScrollView.alwaysBounceHorizontal=YES;
        self.itemScrollView.alwaysBounceVertical=NO;
        [self.itemScrollView setContentSize:CGSizeMake(width*member.hot_items.count, 0)];
        
        self.itemScrollView.pagingEnabled=YES;        
        self.itemScrollView.clipsToBounds=YES;
        
        for (int i=0; i<member.hot_items.count; i++) {
            Hot_itemData *hotItem=member.hot_items[i];
            UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(width*i, 0, width, height)];
            imgView.tag=i;
            [imgView loadImage:hotItem.img placeHolder:img_placehold_small];
            [imgView click:self action:@selector(clickImage:)];
            [self.itemScrollView addSubview:imgView];
        }
    }else{
         [self.itemScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    if (!self.pageControl) {
        self.pageControl = [[TAPageControl alloc] init];
        //self.pageControl.dotSize=CGSizeMake(S(8), S(8));
        [self.pageControl setFrame:CGRectMake(0, 0, 150, 20)];
        self.pageControl.center=CGPointMake(width/2, height-50);
        self.pageControl.currentPage = 0;
        self.pageControl.dotImage=[UIImage imageNamed:@"dot_unselect"];
        self.pageControl.currentDotImage=[UIImage imageNamed:@"dot_select"];
    }
    if (member.status.intValue==0) {
        self.pageControl.center=CGPointMake(width/2, height-kDistance-S(4));
    }else{
        self.pageControl.center=CGPointMake(width/2, height-50);
    }
    self.pageControl.numberOfPages = member.hot_items.count;
    [self.backView addSubview:self.pageControl];
    if (member.hot_items.count>1) {
        self.pageControl.hidden=NO;
    }else{
        self.pageControl.hidden=YES;
    }
    
    NSString *title=[NSString stringWithFormat:@"%@ %@人尝过",member.title,member.orders];
    NSUInteger length=title.length-member.title.length;
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:title];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont FontOfSize:13]
                          range:NSMakeRange(member.title.length, length)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:RED_COLOR
                          range:NSMakeRange(member.title.length, length)];
    [self.labTitle setAttributedText:AttributedStr];
    
    [self.backView bringSubviewToFront:self.labStatus];

    if (member.status.intValue==0) {
        [self.labStatus setHidden:YES];
    }else if (member.status.intValue==1) {
        self.labStatus.backgroundColor=[TEXT_LIGHT colorWithAlphaComponent:0.8f];
        [self.labStatus setHidden:NO];
    }else if (member.status.intValue==2) {
        self.labStatus.backgroundColor=[RED_COLOR colorWithAlphaComponent:0.8f];
        [self.labStatus setHidden:NO];
    }else if (member.status.intValue==3) {
        self.labStatus.backgroundColor=[RED_COLOR colorWithAlphaComponent:0.8f];
        [self.labStatus setHidden:NO];
    }
    if (member.statusDistance.intValue==1) {
        if (member.status.intValue==0) {
            [self.labStatus setHidden:YES];
        }else if (member.status.intValue==1||member.status.intValue==2){
            self.labStatus.backgroundColor=[RED_COLOR colorWithAlphaComponent:0.8f];
            [self.labStatus setHidden:NO];
        }
    }else{
        self.labStatus.backgroundColor=[TEXT_LIGHT colorWithAlphaComponent:0.8f];
        [self.labStatus setHidden:NO];
    }
    [self.labStatus setText:member.statusStr];

    
    [self.iconView load:member.img];
    [self.labTown setText:member.hometown];
    
    NSString *distance=[NSString stringWithFormat:@"%.1fkm",member.distance.floatValue/1000];
    
    [m_descView removeFromSuperview];
    m_descView=nil;
    if (m_descView==nil) {
        m_descView=[[UIView alloc]initWithFrame:CGRectMake(0, 44, width, 15)];
        NSArray *arrayTitle=@[member.address,distance,member.caixi];
        NSArray *images=@[@"home_address",@"home_distance",@"home_caixi"];
        CGFloat orginX=0;
        for (int i=0; i<arrayTitle.count; i++) {
            CGFloat imgWidth=[UIImage imageNamed:images[i]].size.width/2;
            CGFloat width=getTextSize(arrayTitle[i], kMainScreen_Width, [UIFont LightFontOfSize:13]).width+imgWidth+25;
            if (iPhone4||iPhone5) {
                width=MIN(width, 100);
            }else{
                width=MIN(width, 110);
            }
            HomeDescView *descView=[[HomeDescView alloc]initWithFrame:CGRectMake(orginX, 0, width, kImageHeight)];
            descView.isHome=YES;
            [descView setImageWith:images[i] Title:arrayTitle[i]];
            [m_descView addSubview:descView];
            orginX+=width;
            if (i>0) {
                [descView.layer addSublayer:getThinLine(0, 0, 0, kImageHeight, BORDER_COLOR)];
            }
        }
        [self.back2View addSubview:m_descView];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = fabs(scrollView.contentOffset.x) / CGRectGetWidth(scrollView.frame);
    self.pageControl.currentPage=index;
}
-(void)clickImage:(UIGestureRecognizer *)gesture
{
    Hot_itemData *hotItem=_member.hot_items[gesture.view.tag];
    if (self.clickBlock) {
        self.clickBlock(_member,hotItem.Id);
    }
}


@end
