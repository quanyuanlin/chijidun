//
//  TeamOrderCellSmall.m
//  chijidun
//
//  Created by iMac on 16/10/13.
//
//

#import "TeamOrderCellSmall.h"

@implementation TeamOrderCellSmall

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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindWith:(TeamOrderTable *)order
{
    NSString *string=[NSString stringWithFormat:@"%@（%@%@）",[self getDateWith:order.date],[self getWeekWith:order.week],[self getMealTypeWith:order.meal_type]];
    [self.labdate setText:string];
    
    [self.labStatus setText:order.statusStr];
    [self.labFood setText:order.itemStr];
    [self.labOrderTime setText:[NSString stringWithFormat:@"下单时间：%@",order.add_time]];
    [self.labPrice setText:[NSString stringWithFormat:@"￥%@",order.total_price]];
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




