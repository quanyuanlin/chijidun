//
//  DateButton.m
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import "DateButton.h"
#define PI 3.14159265358979323846 

@interface DateButton ()
{
    UILabel *labCenter;
    OrderTimeIntervalTable *itemTable;
    
    UIView *m_pointView;
}
@end
@implementation DateButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addMainView];
    }
    return self;
}
-(void)addMainView
{
    CGSize sizeBtn=self.frame.size;
    labCenter=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    labCenter.center=CGPointMake(sizeBtn.width/2, sizeBtn.height/2);
    labCenter.layer.cornerRadius=25/2;
    labCenter.layer.masksToBounds=YES;
    [labCenter setTextAlignment:NSTextAlignmentCenter];
    [labCenter setFont:[UIFont LightFontOfSize:15]];
    [self addSubview:labCenter];
    
    m_pointView=[[UIView alloc]initWithFrame:CGRectMake(sizeBtn.width/2-2, sizeBtn.height-4.0f, 4.0f, 4.0f)];
    [m_pointView setBackgroundColor:getUIColor(0x5ccd00)];
    m_pointView.layer.cornerRadius=2.0f;
    m_pointView.layer.masksToBounds=YES;
    [self addSubview:m_pointView];
}

-(void)dateButtonSetTitle:(OrderTimeIntervalTable *)item
{
    itemTable=item;
    [labCenter setText:item.day];
    if (item.disable.intValue==0) {
        self.enabled=YES;
        [labCenter setTextColor:getUIColor(0x333333)];
    }else if (item.disable.intValue==1){
        self.enabled=NO;
        [labCenter setTextColor:getUIColor(0xcccccc)];
    }
    m_pointView.hidden=!item.exist.intValue;
}
-(void)setSelected:(BOOL)selected
{
    if (selected) {
        [labCenter setBackgroundColor:getUIColor(0xff5436)];
        [labCenter setTextColor:WHITE_COLOR];
    }else{
        [labCenter setBackgroundColor:[UIColor clearColor]];
        if (itemTable.disable.intValue==0) {
            [labCenter setTextColor:getUIColor(0x333333)];
        }
    }
}

@end







