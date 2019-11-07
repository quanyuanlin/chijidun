//
//  SearchTableViewCellHeader.m
//  chijidun
//
//  Created by iMac on 16/12/7.
//
//

#import "SearchTableViewCellHeader.h"
#define kImageHeight 14
#define kLeftWidth 65
@interface SearchTableViewCellHeader ()
{
    UILabel *m_labTitle;
    UILabel *m_labStatus;
    
    UIView *m_descView;
    MemberTable *_member;
}
@end
@implementation SearchTableViewCellHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labSales setFont:[UIFont LightFontOfSize:13]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindWith:(MemberTable *)member
{
    [self.iconView load:member.img];
    [self.labSales setText:[NSString stringWithFormat:@"%@人尝过",member.sales]];
    
    if (m_labTitle==nil) {
        m_labTitle=[[UILabel alloc]init];
        [m_labTitle setTextColor:TEXT_DEEP];
        [m_labTitle setFont:[UIFont LightFontOfSize:16]];
   }
    CGFloat sizeW=getTextSize(member.title, kMainScreen_Width, [UIFont LightFontOfSize:16]).width;
    [m_labTitle setFrame:CGRectMake(kLeftWidth, kDistance, sizeW, 16)];
    [m_labTitle setText:member.title];
    [self.contentView addSubview:m_labTitle];
    
    if (m_labStatus==nil) {
        m_labStatus=[[UILabel alloc]init];
        [m_labStatus setBackgroundColor:RED_COLOR];
        [m_labStatus setTextColor:WHITE_COLOR];
        [m_labStatus setFont:[UIFont LightFontOfSize:11]];
        [m_labStatus setTextAlignment:NSTextAlignmentCenter];
    }
    
    if (member.statusDistance.intValue==1) {
        if (member.status.intValue==0) {
            [m_labStatus setHidden:YES];
        }else if (member.status.intValue==1){
            m_labStatus.backgroundColor=RED_COLOR;
            [m_labStatus setHidden:NO];
        }else if (member.status.intValue==2){
            m_labStatus.backgroundColor=RED_COLOR;
            [m_labStatus setHidden:NO];
        }
    }else{
        m_labStatus.backgroundColor=getUIColor(0xaaaaaa);
        [m_labStatus setHidden:NO];
    }
    CGFloat sizeS=getTextSize(member.statusStr, kMainScreen_Width, [UIFont LightFontOfSize:11]).width+8;
    [m_labStatus setFrame:CGRectMake(CGRectGetMaxX(m_labTitle.frame)+5, kDistance, sizeS, 16)];
    m_labStatus.layer.cornerRadius=8.0f;
    m_labStatus.layer.masksToBounds=YES;
    [m_labStatus setText:member.statusStr];
    [self.contentView addSubview:m_labStatus];
    
    
    CGFloat width=kMainScreen_Width-90;
    NSString *distance=[NSString stringWithFormat:@"%.1fkm",member.distance.floatValue/1000];
    if (m_descView==nil) {
        m_descView=[[UIView alloc]initWithFrame:CGRectMake(kLeftWidth, 40, width, 15)];
        NSArray *arrayTitle=@[member.address,distance];
        NSArray *images=@[@"home_address",@"home_distance"];
        CGFloat orginX=-kDistanceMin;
        for (int i=0; i<arrayTitle.count; i++) {
            CGFloat imgWidth=[UIImage imageNamed:images[i]].size.width/2;
            CGFloat width=getTextSize(arrayTitle[i], kMainScreen_Width, [UIFont LightFontOfSize:13]).width+imgWidth+25;
            HomeDescView *descView=[[HomeDescView alloc]initWithFrame:CGRectMake(orginX, 0, width, kImageHeight)];
            [descView setImageWith:images[i] Title:arrayTitle[i]];
            [m_descView addSubview:descView];
            orginX+=width;
            if (i>0) {
                [descView.layer addSublayer:getThinLine(0, 0, 0, kImageHeight, BORDER_COLOR)];
            }
        }
    }
    [self.contentView addSubview:m_descView];
}


@end
