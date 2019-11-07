//
//  TeamOrderCellBig.m
//  chijidun
//
//  Created by iMac on 16/10/13.
//
//

#import "TeamOrderCellBig.h"

@interface TeamOrderCellBig ()
{
    TeamOrderTable *_order;
    NSTimer *_timer;    
    NSInteger _seconds;
}
@end
@implementation TeamOrderCellBig

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backView.layer.borderColor=BORDER_COLOR.CGColor;
    self.backView.layer.borderWidth=1.0f;
    self.backView.layer.cornerRadius=5.0f;
    
    [self.labdate setFont:[UIFont LightFontOfSize:14]];
    [self.labStatus setFont:[UIFont LightFontOfSize:15]];
    [self.labFood setFont:[UIFont LightFontOfSize:18]];
    [self.labPrice setFont:[UIFont LightFontOfSize:18]];
    [self.labOrderTime setFont:[UIFont LightFontOfSize:13]];
    [self.btnStatus.titleLabel setFont:[UIFont LightFontOfSize:15]];
    
    self.btnStatus.layer.borderWidth=1.0f;
    self.btnStatus.layer.borderColor=YELLOW_COLOR.CGColor;
    self.btnStatus.layer.cornerRadius=4.0f;
    [self.btnStatus setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnClicked:(id)sender {
    if(_btnStatus.selected) return;
    _btnStatus.selected=YES;
    
    if (_order.status.intValue==0) {
        if (self.payBlock) {
            self.payBlock(_order);
        }
        _btnStatus.selected=NO;
    }
    if (_order.status.intValue==1) {
        if (self.cancelBlock) {
            self.cancelBlock(_order);
        }
         _btnStatus.selected=NO;
    }
}

-(void)bindWith:(TeamOrderTable *)order
{
    _order=order;
    NSString *string=[NSString stringWithFormat:@"%@（%@%@）",[self getDateWith:order.date],[self getWeekWith:order.week],[self getMealTypeWith:order.meal_type]];
    [self.labdate setText:string];
 
    [self.labStatus setText:order.statusStr];
    if (order.status.intValue==0) {
        _seconds=order.countDown.intValue;
        [self.labStatus setTextColor:YELLOW_COLOR];
        
        self.btnStatus.layer.borderColor=YELLOW_COLOR.CGColor;
        [self.btnStatus setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
        [self countDownAction];
        [self.btnStatus.titleLabel setFont:[UIFont LightFontOfSize:13]];
    }else if(order.status.intValue==1){
        [self.labStatus setTextColor:RED_COLOR];
        
        self.btnStatus.layer.borderColor=TEXT_LIGHT.CGColor;
        [self.btnStatus setTitleColor:TEXT_DEEP forState:UIControlStateNormal];
        [self.btnStatus setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.btnStatus.titleLabel setFont:[UIFont LightFontOfSize:15]];
    }else if (order.status.intValue==10){
        [self.labStatus setTextColor:ORANGE_COLOR];
    }else{
        [self.labStatus setTextColor:RED_COLOR];
    }
    [self.labFood setText:order.itemStr];
    [self.labOrderTime setText:[NSString stringWithFormat:@"下单时间：%@",order.add_time]];
    [self.labPrice setText:[NSString stringWithFormat:@"￥%@",order.total_price]];
}
-(void)countDownAction
{
     if (_order.status.intValue==0)
     {
         _seconds--;
         if (_seconds<0) {
             [self.btnStatus setTitle:@"去付款" forState:UIControlStateNormal];
             return;
         }
         NSInteger m=_seconds/60;
         NSInteger s=_seconds%60;
         
         NSString *minute;
         NSString *second;
         if (m<10) {
             minute=[NSString stringWithFormat:@"0%ld",(long)m];
         }else{
             minute=[NSString stringWithFormat:@"%ld",(long)m];
         }
         
         if (s<10) {
             second=[NSString stringWithFormat:@"0%ld",(long)s];
         }else{
             second=[NSString stringWithFormat:@"%ld",(long)s];
         }
         NSString *title=[NSString stringWithFormat:@"去付款%@:%@",minute,second];
         [self.btnStatus setTitle:title forState:UIControlStateNormal];
         if(_seconds==0){
             [_timer invalidate];
             if (self.timerEndBlock) {
                 self.timerEndBlock();
             }
         }
     }    
}
-(NSString *)getDateWith:(NSString *)orderDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:orderDate];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString *dateStr=[dateFormatter stringFromDate:date];
    return dateStr;
}

-(NSString *)getWeekWith:(NSString *)orderWeek
{
    NSDictionary *weekDic=@{@"0":@"周日",
                            @"1":@"周一",
                            @"2":@"周二",
                            @"3":@"周三",
                            @"4":@"周四",
                            @"5":@"周五",
                            @"6":@"周六"};
    NSString *week=[weekDic objectForKey:orderWeek];
    return week;
}
-(NSString *)getMealTypeWith:(NSString *)type
{
    NSDictionary *typeDic=@{@"1":@"早餐",
                            @"2":@"午餐",
                            @"3":@"晚餐"};
    NSString *mealType=[typeDic objectForKey:type];
    return mealType;
}

@end



