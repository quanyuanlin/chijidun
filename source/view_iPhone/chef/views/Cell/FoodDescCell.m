#import "FoodDescCell.h"
#import "ItemTable.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
@interface FoodDescCell () {
    NSInteger foodNum;
    NSArray *m_cartArray;
    int rest;
}
@end

@implementation FoodDescCell
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self.contentView setBackgroundColor:getUIColor(0xf8f8f8)];
    [self.labName setFont:[UIFont LightFontOfSize:17]];
    [self.labDesc setFont:[UIFont LightFontOfSize:12]];
    [self.labRest setFont:[UIFont LightFontOfSize:11]];
    [self.priceLabel setFont:[UIFont LightFontOfSize:18]];
    [self.priceLabel setTextColor:YELLOW_COLOR];
    
    [self.labNum setFont:[UIFont LightFontOfSize:17]];
}

- (void)setSubviewWith:(BOOL)isTomorrow {
    self.bookLabel.hidden = !isTomorrow;
    if (self.memberTable.status.intValue==1) {
        self.addButton.enabled=NO;
    }
}

- (void)cellRefreshDataWith:(ItemTable *)model And:(NSInteger)number {
    self.itemTable=model;
    [self.foodImageView loadImage:model.img placeHolder:img_placehold_big];
    [self.labName setText:model.title];
    [self.labDesc setText:model.item_desc];
    
    self.bookLabel.layer.cornerRadius=9;
    self.bookLabel.layer.masksToBounds=YES;
    self.bookLabel.hidden=YES;
    
    NSString *priceStr = [[NSString alloc] initWithFormat:@"¥%@", model.price];
    [self.priceLabel setText:priceStr];
    [self.priceLabel setTextColor:MAIN_COLOR];
    
    rest=[self.itemTable.stock_perday intValue]-model.cart_num.intValue;
    [self setRestWith:rest];
    
    
    if ([self.memberTable.is_open isEqualToString:@"0"]) {
        [self.labRest setText:[NSString stringWithFormat:@"打烊中 | %@人尝过",model.sales]];
        [self.addButton setImage:[UIImage imageNamed:@"diancanAdd"] forState:UIControlStateNormal];
        self.addButton.enabled=NO;
        self.reduceButton.hidden=YES;
        self.labNum.hidden=YES;
    }
    if ([self.memberTable.is_open isEqualToString:@"1"]) {
        if ([model.cart_num intValue]>0) {
            self.labNum.text=[NSString stringWithFormat:@"%d",[model.cart_num intValue]];
            self.labNum.hidden = NO;
            self.reduceButton.hidden = NO;
            if (rest==0) {
                [self.labRest setText:[NSString stringWithFormat:@"已售馨 | %@人尝过",model.sales]];
                [self.addButton setImage:[UIImage imageNamed:@"diancanAdd"] forState:UIControlStateNormal];
                self.addButton.enabled=NO;
            }else{
                [self.addButton setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
                self.addButton.enabled=YES;
            }
        }else{
            if (rest==0) {
                [self.labRest setText:[NSString stringWithFormat:@"已售馨 | %@人尝过",model.sales]];
                [self.addButton setImage:[UIImage imageNamed:@"diancanAdd"] forState:UIControlStateNormal];
                self.addButton.enabled=NO;
                self.labNum.hidden = YES;
                self.reduceButton.hidden = YES;
            }else{
                [self.addButton setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
                self.addButton.enabled=YES;
                self.labNum.hidden = YES;
                self.reduceButton.hidden = YES;
            }
        }
    }
    if (self.memberTable.statusDistance.intValue==0) {
        [self.addButton setImage:[UIImage imageNamed:@"diancanAdd"] forState:UIControlStateNormal];
        self.addButton.enabled=NO;
        self.labNum.hidden = YES;
        self.reduceButton.hidden = YES;
        if (rest==0) {
            [self.labRest setText:[NSString stringWithFormat:@"已售馨 | %@人尝过",model.sales]];
        }
    }
}

- (IBAction)addFood:(id)sender {
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
        
    if (foodNum > 0) {
        if (_reduceButton.hidden) {
            CATransition *animation = [CATransition animation];
            animation.delegate = self;
            animation.duration = 0.3;
            animation.type = kCATransitionMoveIn;
            animation.subtype = kCATransitionFromRight;
            [[self.reduceButton layer] addAnimation:animation forKey:@"animation"];
        }
        [self.addButton setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        self.labNum.hidden = NO;
        self.labNum.text = [NSString stringWithFormat:@"%ld", (long)foodNum];
        self.reduceButton.hidden = NO;
    }
    _itemTable.cart_num=[NSString stringWithFormat:@"%ld",(long)foodNum];    
    if (self.cartBlock) {
        self.cartBlock(_itemTable,YES);
    }
    
    if (rest ==0) {
        [self.labRest setText:[NSString stringWithFormat:@"已售馨 | %@人尝过",self.itemTable.sales]];
        [self.addButton setImage:[UIImage imageNamed:@"diancanAdd"] forState:UIControlStateNormal];
        self.addButton.enabled=NO;
    }
    
}

- (IBAction)reduceFood:(id)sender {
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
    [self.addButton setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
    self.addButton.enabled=YES;

        
    self.labNum.text = [NSString stringWithFormat:@"%ld", (long)foodNum];
    _itemTable.cart_num=[NSString stringWithFormat:@"%ld",(long)foodNum];
    
    if (self.cartBlock) {
        self.cartBlock(_itemTable,NO);
    }
    
    if (foodNum == 0) {
        self.labNum.hidden = YES;
        self.reduceButton.hidden = YES;
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.3;
        animation.type = kCATransitionReveal;
        animation.subtype = kCATransitionFromLeft;
        [[self.reduceButton layer] addAnimation:animation forKey:@"animation"];
        [self.addButton setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
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



