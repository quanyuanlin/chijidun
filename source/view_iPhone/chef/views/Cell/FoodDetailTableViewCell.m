//
//  FoodDetailTableViewCell.m￥￥￥￥￥￥￥￥￥
//
//  Created by iMac on 16/12/6.
//
//

#import "FoodDetailTableViewCell.h"

@interface FoodDetailTableViewCell ()
{
    ItemTable *_item;
    int _cartNum;
    
    ChefItemTable *_itemTeam;
}
@end
@implementation FoodDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labTitle setFont:[UIFont LightFontOfSize:18]];
    [self.labDesc setFont:[UIFont LightFontOfSize:13]];
    [self.labPrice setFont:[UIFont LightFontOfSize:18]];
    [self.buttonCart.titleLabel setFont:[UIFont LightFontOfSize:15]];
    [self.labPrice setTextColor:YELLOW_COLOR];
    
    [self.buttonCart setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    self.buttonCart.layer.borderColor=YELLOW_COLOR.CGColor;
    self.buttonCart.layer.borderWidth=1.0f;
    self.buttonCart.layer.cornerRadius=15.0f;
    self.buttonCart.layer.masksToBounds=YES;
    
    self.buttonSellOut.layer.borderColor=DISABLE_COLOR.CGColor;
    self.buttonSellOut.layer.borderWidth=1.0f;
    self.buttonSellOut.layer.cornerRadius=15.0f;
    self.buttonSellOut.layer.masksToBounds=YES;
    self.buttonSellOut.hidden=YES;
    
    [self.btnBackView setHidden:YES];
    [self.labNum setFont:[UIFont LightFontOfSize:17]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonCartClicked:(id)sender
{
    if (_isTeam) {
        _cartNum=1;
        [self changeTeamNumWith:YES];
    }else{
        USER *user = [[App shared] currentUser];
        if (user.token.length==0) {
            ChefDetailVC *chefVC = (ChefDetailVC *) self.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder;
            [chefVC presentVC:[LoginViewController new]];
            return;
        }
        _cartNum=1;
        [self changeNumWith:YES];
    }
}

- (IBAction)buttonAddClicked:(id)sender
{
    if (_isTeam) {
        _cartNum++;
        [self changeTeamNumWith:YES];
    }else{
        USER *user = [[App shared] currentUser];
        if (user.token.length==0) {
            ChefDetailVC *chefVC = (ChefDetailVC *) self.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder;
            [chefVC presentVC:[LoginViewController new]];
            return;
        }
        _cartNum++;
        [self changeNumWith:YES];
    }
}

- (IBAction)buttonMinusClicked:(id)sender
{
    if (_isTeam) {
        _cartNum--;
        [self changeTeamNumWith:NO];
    }else{
        USER *user = [[App shared] currentUser];
        if (user.token.length==0) {
            ChefDetailVC *chefVC = (ChefDetailVC *) self.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder;
            [chefVC presentVC:[LoginViewController new]];
            return;
        }
        if (_cartNum>0) {
            _cartNum--;
            [self changeNumWith:NO];
        }
    }
}

-(void)bindWith:(ItemTable *)item
{
    _item=item;
    _cartNum=item.cart_num.intValue;
    
    [self.labTitle setText:item.title];
    [self.labDesc setText:[NSString stringWithFormat:@"%@人尝过",item.sales]];
    [self.labPrice setText:[NSString stringWithFormat:@"￥%@",item.price]];
    if (item.stock_perday.intValue==0) {
        self.buttonSellOut.hidden=NO;
        self.btnBackView.hidden=YES;
        self.buttonCart.hidden=YES;
    }else{
        self.buttonSellOut.hidden=YES;
        if (item.cart_num.intValue>0) {
            self.btnBackView.hidden=NO;
            self.buttonCart.hidden=YES;
            [self.labNum setText:item.cart_num];
            int rest=[_item.stock_perday intValue]-_cartNum;
            if (rest>0) {
                [self.buttonAdd setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
                self.buttonAdd.enabled=YES;
            }else{
                [self.buttonAdd setImage:[UIImage imageNamed:@"diancanAdd"] forState:UIControlStateNormal];
                self.buttonAdd.enabled=NO;
            }
        }else{
            self.btnBackView.hidden=YES;
            self.buttonCart.hidden=NO;
            
        }
    }

    if (_member.statusDistance.intValue==1) {
        if (_member.status.intValue==0) {
            self.buttonCart.enabled=YES;
            [self.buttonCart setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
            self.buttonCart.layer.borderColor=YELLOW_COLOR.CGColor;
        }else{
            if (_member.status.intValue==1||_member.status.intValue==2) {
                if (_isTomorrow) {
                    self.buttonCart.enabled=YES;
                    [self.buttonCart setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
                    self.buttonCart.layer.borderColor=YELLOW_COLOR.CGColor;
                }else{
                    self.buttonCart.enabled=NO;
                    [self.buttonCart setTitleColor:DISABLE_COLOR forState:UIControlStateNormal];
                    self.buttonCart.layer.borderColor=DISABLE_COLOR.CGColor;
                    self.btnBackView.hidden=YES;
                    self.buttonCart.hidden=NO;
                }
            }else{
                self.buttonCart.enabled=NO;
                [self.buttonCart setTitleColor:DISABLE_COLOR forState:UIControlStateNormal];
                self.buttonCart.layer.borderColor=DISABLE_COLOR.CGColor;
                self.btnBackView.hidden=YES;
                self.buttonCart.hidden=NO;
            }
        }
    }else{
        self.buttonCart.enabled=NO;
        [self.buttonCart setTitleColor:DISABLE_COLOR forState:UIControlStateNormal];
        self.buttonCart.layer.borderColor=DISABLE_COLOR.CGColor;
        self.btnBackView.hidden=YES;
        self.buttonCart.hidden=NO;
    }
}
-(void)changeNumWith:(BOOL)add
{
    if (_cartNum==0) {
        self.btnBackView.hidden=YES;
        self.buttonCart.hidden=NO;
    }else{
        self.buttonCart.hidden=YES;
        self.btnBackView.hidden=NO;
    }
    int rest=[_item.stock_perday intValue]-_cartNum;
    if (rest>0) {
        [self.buttonAdd setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        self.buttonAdd.enabled=YES;
    }else{
        [self.buttonAdd setImage:[UIImage imageNamed:@"diancanAdd"] forState:UIControlStateNormal];
        self.buttonAdd.enabled=NO;
    }
    
    _item.cart_num=[NSString stringWithFormat:@"%d",_cartNum];
    [self.labNum setText:_item.cart_num];
    if (self.cartBlock) {
        self.cartBlock(_item,add);
    }
}


-(void)bindWithTeam:(ChefItemTable *)item
{
    if (_responseData.order.Id.length>0||!item.enable) {
        self.buttonCart.enabled=NO;
        [self.buttonCart setTitleColor:DISABLE_COLOR forState:UIControlStateNormal];
        self.buttonCart.layer.borderColor=DISABLE_COLOR.CGColor;
    }else{
        self.buttonCart.enabled=YES;
        [self.buttonCart setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
        self.buttonCart.layer.borderColor=YELLOW_COLOR.CGColor;
    }
    
    _itemTeam=item;
    _cartNum=item.num.intValue;
    
    [self.labDesc setHidden:YES];
    self.buttonSellOut.hidden=YES;
    [self.labTitle setText:item.title];
    [self.labPrice setText:[NSString stringWithFormat:@"￥%@",item.price]];
    
    if (item.num.intValue==0) {
        self.btnBackView.hidden=YES;
        self.buttonCart.hidden=NO;
    }else{
        self.buttonCart.hidden=YES;
        self.btnBackView.hidden=NO;
    }
    [self.labNum setText:item.num];
    
}
-(void)changeTeamNumWith:(BOOL)add
{
    if (_cartNum==0) {
        self.btnBackView.hidden=YES;
        self.buttonCart.hidden=NO;
    }else{
        self.buttonCart.hidden=YES;
        self.btnBackView.hidden=NO;
    }    
    _itemTeam.num=[NSString stringWithFormat:@"%d",_cartNum];
    [self.labNum setText:_itemTeam.num];
    if (self.teamCartBlock) {
        self.teamCartBlock(_itemTeam,add);
    }
}
@end




