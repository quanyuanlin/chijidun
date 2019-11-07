//
//  TeamCartCell.m
//  chijidun
//
//  Created by iMac on 16/9/23.
//
//

#import "TeamCartCell.h"

@interface TeamCartCell ()
{
    ChefItemTable *_item;
    
    ItemTable *_itemTable;
    int _number;
    
    UILabel *m_labRice;
}
@end
@implementation TeamCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labName setFont:[UIFont LightFontOfSize:17]];
    [self.labNum setFont:[UIFont LightFontOfSize:17]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)btnAddClicked:(id)sender
{
    _number++;
    [self changeNumWith:_number];
}

- (IBAction)btnSubClicked:(id)sender
{
    if (_number>=1) {
        _number--;
    }
    [self changeNumWith:_number];
}
-(void)bindWith:(ChefItemTable *)item
{
    _item=item;
    [self.labName setText:item.title];
    [self.labPrice setText:[NSString stringWithFormat:@"￥%@",item.price]];
    [self.labNum setText:item.num];
    if (_responseData.payType.intValue==0) {
        float totalMoney=0;
        for (ChefItemTable *item in _carts) {
            totalMoney=totalMoney+item.num.intValue*item.price.floatValue;
        }
        
        if (totalMoney>=_responseData.charge.floatValue) {
            self.btnAdd.userInteractionEnabled=NO;
            [self.btnAdd setImage:[UIImage imageNamed:@"icon-add-forbid"] forState:UIControlStateNormal];
            return;
        }else{
            self.btnAdd.userInteractionEnabled=YES;
            [self.btnAdd setImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
        }
    }    
    _number=self.labNum.text.intValue;
}
-(void)changeNumWith:(int)num
{
    [self.labNum setText:[NSString stringWithFormat:@"%d",_number]];
    if (_isPersonnal) {
        self.changeBlock(_itemTable,num);
    }else{
        self.numBlock(_item,num);
    }
}

-(void)bindItemWith:(ItemTable *)item
{
    if (m_labRice==nil) {
        m_labRice=[[UILabel alloc]init];
        [m_labRice setText:@"请确认米饭份数"];
        [m_labRice setFont:[UIFont LightFontOfSize:10]];
        [m_labRice setTextColor:RED_COLOR];
    }
    [self.contentView addSubview:m_labRice];
    if (item.is_rice.intValue==1) {
        self.labNameTopConstraint.constant=7;
        [m_labRice setFrame:CGRectMake(kDistance, 35, 120, 12)];
        [m_labRice setHidden:NO];
    }else{
        self.labNameTopConstraint.constant=12;
        [m_labRice setHidden:YES];
    }
    _itemTable=item;
    [self.labName setText:item.title];
    
    [self.labNum setText:item.cart_num];
    float total=item.price.floatValue*item.cart_num.intValue;
    int t=(int)total;
    NSString *money=[NSString stringWithFormat:@"￥%.1f",total];
    if (total==t) {
        money=[NSString stringWithFormat:@"￥%d",t];
    }
    [self.labPrice setText:money];
    
    _number=self.labNum.text.intValue;
    if (_number>=item.stock_perday.intValue) {
        self.btnAdd.userInteractionEnabled=NO;
        [self.btnAdd setImage:[UIImage imageNamed:@"icon-add-forbid"] forState:UIControlStateNormal];
    }else{
        self.btnAdd.userInteractionEnabled=YES;
        [self.btnAdd setImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
    }
    if (_number==0) {
        self.btnSub.userInteractionEnabled=NO;
        [self.btnSub setImage:[UIImage imageNamed:@"icon-sub-forbid"] forState:UIControlStateNormal];
        [self.labNum setTextColor:TEXT_LIGHT];
    }else{
        self.btnSub.userInteractionEnabled=YES;
        [self.btnSub setImage:[UIImage imageNamed:@"icon-sub"] forState:UIControlStateNormal];
        [self.labNum setTextColor:TEXT_DEEP];
    }
}

@end







