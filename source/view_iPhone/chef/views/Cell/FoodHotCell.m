//
//  FoodHotCell.m
//  
//
//  Created by iMac on 16/1/5.
//
//

#import "FoodHotCell.h"
@interface FoodHotCell () {
    NSInteger foodNum;
    int rest;
}
@end
@implementation FoodHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView setBackgroundColor:getUIColor(0xf8f8f8)];
    
    [self.labPrice setTextColor:YELLOW_COLOR];
    [self.labPrecent setFont:[UIFont LightFontOfSize:12]];
    
    [self.labName setFont:[UIFont LightFontOfSize:17]];
    [self.labDesc setFont:[UIFont LightFontOfSize:12]];
    [self.labRest setFont:[UIFont LightFontOfSize:12]];
    
    [self.labNum setFont:[UIFont LightFontOfSize:17]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)bindWith:(ItemTable *)item
{
    self.itemTable=item;
    
    [self.foodImageView loadImage:item.img placeHolder:img_placehold_big];
    [self.labName setText:item.title];
    [self.labDesc setText:item.item_desc];
    rest=[item.stock_perday intValue]-item.cart_num.intValue;

    [self setRestWith:rest];
    
    [self.labPrice setText:[NSString stringWithFormat:@"¥%@", item.price]];
    if (item.is_hots.intValue==1) {
        [self.hotView setHidden:NO];
        [self.labPrecent setHidden:NO];
        if (item.recommand_desc.length>0) {
            CGFloat width=getTextSize(item.recommand_desc, kMainScreen_Width, [UIFont LightFontOfSize:12]).width;
            self.hotViewWidth.constant=width+12+15;
            self.labHotWidth.constant=width+12 ;
            [self.labPrecent setText:item.recommand_desc];
        }else{
            self.hotViewWidth.constant=62;
            self.labHotWidth.constant=50;
            [self.labPrecent setText:@"拿手菜"];
        }
    }else{
        [self.hotView setHidden:YES];
        [self.labPrecent setHidden:YES];
    }
    
    if ([self.memberTable.is_open isEqualToString:@"0"]) {
       [self.labRest setText:[NSString stringWithFormat:@"打烊中 | %@人尝过",item.sales]];
        [self.buttonAdd setImage:[UIImage imageNamed:@"diancanAdd"] forState:UIControlStateNormal];
        self.buttonAdd.enabled=NO;
        self.buttonMinus.hidden=YES;
        self.labNum.hidden=YES;
    }
    if ([self.memberTable.is_open isEqualToString:@"1"]) {
        if ([item.cart_num intValue]>0) {
            self.labNum.text=[NSString stringWithFormat:@"%d",[item.cart_num intValue]];
            self.labNum.hidden = NO;
            self.buttonMinus.hidden = NO;
            if (rest==0) {
                [self.labRest setText:[NSString stringWithFormat:@"已售馨 | %@人尝过",item.sales]];
                [self.buttonAdd setImage:[UIImage imageNamed:@"diancanAdd"] forState:UIControlStateNormal];
                self.buttonAdd.enabled=NO;
            }else{
                [self.buttonAdd setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
                self.buttonAdd.enabled=YES;
            }
        }else{
            if (rest==0) {
                [self.labRest setText:[NSString stringWithFormat:@"已售馨 | %@人尝过",item.sales]];
                [self.buttonAdd setImage:[UIImage imageNamed:@"diancanAdd"] forState:UIControlStateNormal];
                self.buttonAdd.enabled=NO;
                self.labNum.hidden = YES;
                self.buttonMinus.hidden = YES;
            }else{
                [self.buttonAdd setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
                self.buttonAdd.enabled=YES;
                self.labNum.hidden = YES;
                self.buttonMinus.hidden = YES;
            }
        }
    }
    
    if (self.memberTable.statusDistance.intValue==0) {
        [self.buttonAdd setImage:[UIImage imageNamed:@"diancanAdd"] forState:UIControlStateNormal];
        self.buttonAdd.enabled=NO;
        self.labNum.hidden = YES;
        self.buttonMinus.hidden = YES;
        if (rest==0) {
            [self.labRest setText:[NSString stringWithFormat:@"已售馨 | %@人尝过",item.sales]];
        }
    }
}
- (IBAction)buttonAddTapped:(id)sender {
    USER *user = [[App shared] currentUser];
    if (user.token.length==0) {
        ChefDetailVC *chefVC = (ChefDetailVC *) self.nextResponder.nextResponder.nextResponder.nextResponder;
        [chefVC presentVC:[LoginViewController new]];
        return;
    }
    foodNum=[self.itemTable.cart_num intValue];
    foodNum++;
    rest--;
    [self setRestWith:rest];

    _itemTable.cart_num=[NSString stringWithFormat:@"%ld",(long)foodNum];
    if (self.cartBlock) {
        self.cartBlock(_itemTable,YES);
    }    
    
    if (foodNum > 0) {
        if (_buttonMinus.hidden) {
            CATransition *animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 0.3;
            animation.type = kCATransitionMoveIn;
            animation.subtype = kCATransitionFromRight;
            [[self.buttonMinus layer] addAnimation:animation forKey:@"animation"];
        }
        [self.buttonAdd setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        self.labNum.hidden = NO;
        self.labNum.text = [NSString stringWithFormat:@"%ld", (long)foodNum];
        self.buttonMinus.hidden = NO;
    }
    if (rest ==0) {
        [self.labRest setText:[NSString stringWithFormat:@"已售馨 | %@人尝过",self.itemTable.sales]];
        [self.buttonAdd setImage:[UIImage imageNamed:@"diancanAdd"] forState:UIControlStateNormal];
        self.buttonAdd.enabled=NO;
    }
}

- (IBAction)buttonMinusTapped:(id)sender {
    USER *user = [[App shared] currentUser];
    if (user.token.length==0) {
        ChefDetailVC *chefVC = (ChefDetailVC *) self.nextResponder.nextResponder.nextResponder.nextResponder;
        [chefVC presentVC:[LoginViewController new]];
        return;
    }
    foodNum=[self.labNum.text intValue];
    foodNum--;
    
    rest++;
    [self setRestWith:rest];
    [self.buttonAdd setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
    self.buttonAdd.enabled=YES;
    
    self.labNum.text = [NSString stringWithFormat:@"%ld", (long)foodNum];
    _itemTable.cart_num=[NSString stringWithFormat:@"%ld",(long)foodNum];
    
    if (self.cartBlock) {
        self.cartBlock(_itemTable,NO);
    }
    
    if (foodNum == 0) {
        self.labNum.hidden = YES;
        self.buttonMinus.hidden = YES;
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.3;
        animation.type = kCATransitionReveal;
        animation.subtype = kCATransitionFromLeft;
        [[self.buttonMinus layer] addAnimation:animation forKey:@"animation"];
        [self.buttonAdd setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
    }
}
-(void)setRestWith:(int)rests
{
    [self.labRest setTextColor:TEXT_DEEP];
    NSString *string=[NSString stringWithFormat:@"剩%d份 | %@人尝过",rests,_itemTable.sales];
    NSString *numStr=[NSString stringWithFormat:@"%d",rests];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:RED_COLOR
                          range:NSMakeRange(1, numStr.length)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont FontOfSize:11]
                          range:NSMakeRange(numStr.length+3, _itemTable.sales.length+5)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:BORDER_COLOR
                          range:NSMakeRange(numStr.length+3, 1)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:TEXT_MIDDLE
                          range:NSMakeRange(numStr.length+4, _itemTable.sales.length+4)];
    
    self.labRest.attributedText = AttributedStr;
}


@end







