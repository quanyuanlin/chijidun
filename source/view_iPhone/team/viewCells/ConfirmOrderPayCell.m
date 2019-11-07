//
//  ConfirmOrderPayCell.m
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import "ConfirmOrderPayCell.h"

@interface ConfirmOrderPayCell ()
{
    NSString *_payType;
    NSInteger _row;
}
@end
@implementation ConfirmOrderPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labTitle setFont:[UIFont LightFontOfSize:16]];
    [self.labDesc setFont:[UIFont LightFontOfSize:12]];
    [self.labPay setFont:[UIFont LightFontOfSize:15]];
    
    [self.btnSelect setImage:[UIImage imageNamed:@"icon_check_border_grey"] forState:UIControlStateNormal];
    [self.btnSelect setImage:[UIImage imageNamed:@"icon_check_border_yellow"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnSelectClicked:(id)sender {
    if (_payType.intValue==2&&_row==0) {
        return;
    }
    if (self.btnSelect.selected) {
        [self.btnSelect setSelected:NO];
    }else{
        [self.btnSelect setSelected:YES];
    }
}
-(void)bindWithType:(ConfirmOrderResponse *)response Row:(NSInteger)indexRow
{
    _payType=response.payType;
    _row=indexRow;
    if (indexRow==0) {
        [self.labTitle setText:@"企业支付"];
        [self.labDesc setText:@"企业买单个人无需支付"];
    
        if (response.payType.intValue==1) {
            [self.labPay setText:[NSString stringWithFormat:@"最高可代付%@元",response.companyPay]];
            [self.imgView setImage:[UIImage imageNamed:@"icon_company_grey"]];
            [self.btnSelect setEnabled:NO];
            
            [self.labTitle setTextColor:TEXT_LIGHT];
            [self.labDesc setTextColor:BORDER_COLOR];
            [self.labPay setTextColor:BORDER_COLOR];
        }else{
            [self.labTitle setTextColor:TEXT_DEEP];
            [self.labDesc setTextColor:TEXT_LIGHT];
            [self.labPay setTextColor:TEXT_MIDDLE];
            
            NSString *money=[NSString stringWithFormat:@"最高可代付%@元",response.companyPay];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:getUIColor(0xff6600)
                                  range:NSMakeRange(5, response.companyPay.length)];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont FontOfSize:15]
                                  range:NSMakeRange(5, response.companyPay.length)];
            self.labPay.attributedText = AttributedStr;
            [self.imgView setImage:[UIImage imageNamed:@"icon_company"]];
            [self.btnSelect setSelected:YES];
        }
        
    }else{
        [self.labTitle setTextColor:TEXT_DEEP];
        [self.labDesc setTextColor:TEXT_LIGHT];
        [self.labPay setTextColor:TEXT_MIDDLE];
        
        [self.imgView setImage:[UIImage imageNamed:@"icon_necktie"]];
        [self.labTitle setText:@"个人支付"];
        [self.labDesc setText:@"支付宝、微信等"];
        
        if (response.payType.intValue==0) {
            [self.labPay setText:@"我是土豪我自己付"];
        }else{
            NSString *money=[NSString stringWithFormat:@"个人还需支付%@元",response.userPay];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:money];
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:ORANGE_COLOR
                                  range:NSMakeRange(6, response.userPay.length)];
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont FontOfSize:15]
                                  range:NSMakeRange(6, response.companyPay.length)];
            self.labPay.attributedText = AttributedStr;
            [self.btnSelect setSelected:YES];
        }
    }
}


@end
