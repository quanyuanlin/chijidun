//
//  TeamOrderListCell.m
//  chijidun
//
//  Created by iMac on 16/9/21.
//
//

#import "TeamOrderListCell.h"

@implementation TeamOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.cornerRadius=5.0f;
    self.backView.layer.borderWidth=1.0f;
    self.backView.layer.borderColor=getUIColor(0xdddddd).CGColor;
    
    self.labStatus.layer.cornerRadius=12.0f;
    self.labStatus.layer.masksToBounds=YES;
    
    self.labType.layer.cornerRadius=12.0f;
    self.labType.layer.masksToBounds=YES;
    
    [self.labWeek setFont:[UIFont LightFontOfSize:17]];
    [self.labDate setFont:[UIFont LightFontOfSize:13]];
    [self.labMeal setFont:[UIFont LightFontOfSize:17]];
    [self.labTime setFont:[UIFont LightFontOfSize:13]];
    [self.labChef setFont:[UIFont LightFontOfSize:13]];
    [self.labStatus setFont:[UIFont LightFontOfSize:15]];
    [self.labType setFont:[UIFont LightFontOfSize:17]];
    [self.labFood setFont:[UIFont LightFontOfSize:15]];
    
    CGFloat width=(kMainScreen_Width-2*kDistanceMin-2*kDistance)/3;
    self.leftConstraint.constant=width+kDistance;
    self.rightConstraint.constant=width+kDistance;
    if (iPhone4||iPhone5) {
        self.labDateConstraint.constant=0;
        self.labTimeConstraint.constant=0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)bindWith:(OrderIndexTable *)item
{
    //state 0 未点餐 1 待支付 2已点餐 3已截止
    //category 0无 厨师类型 1私厨2餐厅
    [self.labWeek setText:item.week];
    [self.labDate setText:item.date];
    [self.labMeal setText:item.types];
    [self.labChef setText:item.member_name.length>0 ? item.member_name : @"--"];
    [self.labTime setText: [item.etime substringToIndex:5]];
    [self.labStatus setText:item.status];
    [self.labFood setText:item.menu.length>0 ? item.menu : @"--"];
    
    if (item.disable.intValue==0) {
        [self.labWeek setTextColor:getUIColor(0x333333)];
        [self.labDate setTextColor:getUIColor(0x999999)];
        [self.labMeal setTextColor:getUIColor(0x333333)];
        [self.labTime setTextColor:getUIColor(0x999999)];
        
        if (item.state.intValue==0) {
            [self.labStatus setBackgroundColor:RED_COLOR];
        }else if (item.state.intValue==1){
            [self.labStatus setBackgroundColor:YELLOW_COLOR];
        }else if (item.state.intValue==2){
            [self.labStatus setBackgroundColor:GREEN_COLOR];
        }else if (item.state.intValue==3){
            [self.labStatus setBackgroundColor:BORDER_COLOR];
        }
        
        if (item.category.intValue==1) {
            [self.labType setBackgroundColor:getUIColor(0x7ecc1e)];
            [self.labType setText:@"私"];
            [self.labType setTextColor:WHITE_COLOR];
        }else if (item.category.intValue==2){
            [self.labType setBackgroundColor:BLUE_COLOR];
            [self.labType setText:@"厅"];
            [self.labType setTextColor:WHITE_COLOR];
        }else{
            [self.labType setBackgroundColor:WHITE_COLOR];
            [self.labType setText:@"--"];
            [self.labType setTextColor:getUIColor(0x333333)];
        }
    }else{
        [self.labWeek setTextColor:BORDER_COLOR];
        [self.labDate setTextColor:BORDER_COLOR];
        [self.labMeal setTextColor:BORDER_COLOR];
        [self.labTime setTextColor:BORDER_COLOR];
        [self.labStatus setBackgroundColor:BORDER_COLOR];
        [self.labType setText:@"--"];
        [self.labType setTextColor:getUIColor(0x333333)];
        [self.labType setBackgroundColor:[UIColor clearColor]];
    }
    
    
}



@end
