//
//  TeamPaymentCell.m
//  chijidun
//
//  Created by iMac on 16/9/28.
//
//

#import "TeamPaymentCell.h"
#define AliPay @"aliPay"
#define WXPay @"wxPay"
#define CharPay @"characterPay"

@implementation TeamPaymentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.labTitle setFont:[UIFont LightFontOfSize:16]];
    [self.labDesc setFont:[UIFont LightFontOfSize:12]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)bindWith:(NSDictionary *)data
{
    if ([data[@"name"] isEqualToString:AliPay]) {
        [self.labTitle setText:@"支付宝"];
        [self.labDesc setText:data[@"introduction"]];
        [self.labDesc setTextColor:[self hexStringToColor:data[@"color"]]];
        [self.iconView setImage:[UIImage imageNamed:@"icon_alipay"]];
    }
    if ([data[@"name"] isEqualToString:WXPay]) {
        [self.labTitle setText:@"微信支付"];
        [self.labDesc setText:data[@"introduction"]];
        [self.labDesc setTextColor:[self hexStringToColor:data[@"color"]]];
        [self.iconView setImage:[UIImage imageNamed:@"icon_wechat"]];
    }
    if ([data[@"name"] isEqualToString:CharPay]) {
        [self.labTitle setText:@"51人品买单"];
        [self.labDesc setText:data[@"introduction"]];
        [self.labDesc setTextColor:[self hexStringToColor:data[@"color"]]];
        [self.iconView setImage:[UIImage imageNamed:@"icon_rpPay"]];
    }
}
-(UIColor *)hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end
