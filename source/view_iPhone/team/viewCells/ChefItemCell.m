//
//  ChefItemCell.m
//  chijidun
//
//  Created by iMac on 16/9/23.
//
//

#import "ChefItemCell.h"
#define LabWidth 120

@interface ChefItemCell ()
{
    UILabel *m_labTitle;
    UILabel *m_labDesc;
    
    int _num;
    ChefItemTable *_item;
}
@end
@implementation ChefItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backView.layer.cornerRadius=25.0f;
    self.backView.layer.masksToBounds=YES;
    self.btnAdd.layer.cornerRadius=10.0f;
    self.btnAdd.layer.masksToBounds=YES;
    [self.btnSub setHidden:YES];
    [self.labPrice setFont:[UIFont LightFontOfSize:15]];
    
    CGFloat orginX=25;
    if (m_labTitle==nil) {
        m_labTitle=[[UILabel alloc]initWithFrame:CGRectMake(orginX, 5, LabWidth, 20)];
        [m_labTitle setTextColor:getUIColor(0x333333)];
        [m_labTitle setFont:[UIFont LightFontOfSize:17]];
    }
    [self.backView addSubview:m_labTitle];
    
    if (m_labDesc==nil) {
        m_labDesc=[[UILabel alloc]initWithFrame:CGRectMake(orginX, 30, LabWidth, 17)];
        [m_labDesc setTextColor:getUIColor(0x666666)];
        [m_labDesc setFont:[UIFont LightFontOfSize:15]];
    }
    [self.backView addSubview:m_labDesc];
    [self.backView click:self action:@selector(clickBack:)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)btnSubClicked:(id)sender {
    _num--;
    [self changeSubViews];
    self.plusBlock(_item,_num,NO);
}

- (IBAction)btnAddClicked:(id)sender {
    [self verifyBtnsWith:YES];
    _num++;
    [self changeSubViews];
    self.plusBlock(_item,_num,YES);
}

-(void)bindWith:(ChefItemTable *)item
{
    [self verifyBtnsWith:NO];
    _item=item;
    _num=item.num.intValue;
    if (_responseData.disable.intValue==1) {
        _item.enable=NO;
        [self.labPrice setTextColor:BORDER_COLOR];
        [self.btnAdd setImage:[UIImage imageNamed:@"icon-add-forbid"] forState:UIControlStateNormal];
        self.btnAdd.enabled=NO;
    }else{
        if (_responseData.timeDisable.intValue!=0) {
            if (_responseData.timeDisable.intValue==2) {
                _item.enable=NO;
                [self.labPrice setTextColor:BORDER_COLOR];
                [self.btnAdd setImage:[UIImage imageNamed:@"icon-add-forbid"] forState:UIControlStateNormal];
                self.btnAdd.enabled=NO;
            }else{
                if ([_leftTilte isEqualToString:@"私厨"]) {
                    _item.enable=NO;
                    [self.labPrice setTextColor:BORDER_COLOR];
                    [self.btnAdd setImage:[UIImage imageNamed:@"icon-add-forbid"] forState:UIControlStateNormal];
                    self.btnAdd.enabled=NO;
                }else{
                    if (_chef.status.intValue==1) {
                        _item.enable=NO;
                        [self.labPrice setTextColor:BORDER_COLOR];
                        [self.btnAdd setImage:[UIImage imageNamed:@"icon-add-forbid"] forState:UIControlStateNormal];
                        self.btnAdd.enabled=NO;
                    }else{
                        _item.enable=YES;
                        [self.labPrice setTextColor:ORANGE_COLOR];
                        [self.btnAdd setImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
                        [self changeSubViews];
                        self.btnAdd.enabled=YES;
                    }
                }
            }
        }else{
            if (_chef.status.intValue==1) {
                _item.enable=NO;
                [self.labPrice setTextColor:BORDER_COLOR];
                [self.btnAdd setImage:[UIImage imageNamed:@"icon-add-forbid"] forState:UIControlStateNormal];
                self.btnAdd.enabled=NO;
            }else{
                if (_responseData.order.Id==nil) {
                    _item.enable=YES;
                    [self.labPrice setTextColor:ORANGE_COLOR];
                    [self.btnAdd setImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
                    [self changeSubViews];
                    self.btnAdd.enabled=YES;
                }else{
                    _item.enable=NO;
                    [self.labPrice setTextColor:BORDER_COLOR];
                    [self.btnAdd setImage:[UIImage imageNamed:@"icon-add-forbid"] forState:UIControlStateNormal];
                    self.btnAdd.enabled=NO;
                }
            }
        }
        
    }
    CGFloat orginX=m_labTitle.frame.origin.x;
    if (item.item_desc.length>0) {
        [m_labTitle setFrame:CGRectMake(orginX, 5, LabWidth, 20)];
        [m_labDesc setHidden:NO];
    }else{
        [m_labTitle setFrame:CGRectMake(orginX, 15, LabWidth, 20)];
        [m_labDesc setHidden:YES];
    }
    [m_labTitle setText:item.title];
    [m_labDesc setText:item.item_desc];
    [self.labPrice setText:[NSString stringWithFormat:@"￥%@",item.price]];
}
-(void)changeSubViews
{
    if (_num>0) {
        CGFloat orginX=35;
        CGPoint point = m_labTitle.center;
        point.x = orginX+LabWidth/2;
        [m_labTitle setCenter:point];
        
        CGPoint point2 = m_labDesc.center;
        point2.x = orginX+LabWidth/2;
        [m_labDesc setCenter:point2];
        
        CGPoint point3 = self.btnSub.center;
        point3.x = 10+kDistanceMin;
        [self.btnSub setCenter:point3];
        
        [self.backView setBackgroundColor:MAIN_COLOR];
        [m_labTitle setTextColor:WHITE_COLOR];
        [m_labDesc setTextColor:WHITE_COLOR];
        [self.labDots setTextColor:WHITE_COLOR];
        [self.labPrice setTextColor:WHITE_COLOR];
        [self.btnSub setHidden:NO];
        [self.btnAdd.titleLabel setFont:[UIFont FontOfSize:13]];
        [self.btnAdd setTitle:[NSString stringWithFormat:@"%d",_num] forState:UIControlStateNormal];
        [self.btnAdd setBackgroundColor:WHITE_COLOR];
        [self.btnAdd setImage:nil forState:UIControlStateNormal];
        [self.btnAdd setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
    }else{
        CGFloat orginX=25;
        CGPoint point = m_labTitle.center;
        point.x = orginX+LabWidth/2;
        [m_labTitle setCenter:point];
        
        CGPoint point2 = m_labDesc.center;
        point2.x = orginX+LabWidth/2;
        [m_labDesc setCenter:point2];
        
        CGPoint point3 = self.btnSub.center;
        point3.x = 10;
        [self.btnSub setCenter:point3];
        
        [self.backView setBackgroundColor:WHITE_COLOR];
        [self.btnSub setHidden:YES];
        [m_labTitle setTextColor:getUIColor(0x333333)];
        [m_labDesc setTextColor:getUIColor(0x666666)];
        [self.labDots setTextColor:getUIColor(0x666666)];
        [self.labPrice setTextColor:MAIN_COLOR];
        [self.btnAdd setImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
        [self verifyBtnsWith:NO];
    }
}
-(void)verifyBtnsWith:(BOOL)plus
{
    if (_responseData.payType.intValue==0) {
        float totalMoney=0;
        for (ChefItemTable *item in _carts) {
            totalMoney=totalMoney+item.num.intValue*item.price.floatValue;
        }
        totalMoney+=_item.price.intValue;
        if (totalMoney>_responseData.charge.floatValue) {
            self.btnAdd.userInteractionEnabled=NO;
            [self.btnAdd setImage:[UIImage imageNamed:@"icon-add-forbid"] forState:UIControlStateNormal];
            [self.labPrice setTextColor:BORDER_COLOR];

            [self.backView click:self action:nil];
            self.btnSub.userInteractionEnabled=YES;
            return;
        }else{
            self.btnAdd.userInteractionEnabled=YES;
            [self.btnAdd setImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
            [self.labPrice setTextColor:YELLOW_COLOR];

            [self.backView click:self action:@selector(btnAddClicked:)];
            self.btnSub.userInteractionEnabled=YES;
        }
    }
}
-(void)showDetailView
{
    if (self.showDetailBlock) {
        self.showDetailBlock(_item);
    }
}
-(void)clickBack:(UIGestureRecognizer *)gesture
{
    CGFloat width=gesture.view.frame.size.width;
    CGFloat pointX=[gesture locationInView:gesture.view].x;

    if (pointX<50) {
        if (_item.enable) {
            _num--;
            [self changeSubViews];
            self.plusBlock(_item,_num,NO);
        }
    }else if (pointX>(width-50)){
        if (_item.enable) {
            [self verifyBtnsWith:YES];
            _num++;
            [self changeSubViews];
            self.plusBlock(_item,_num,YES);
        }
    }else{
        [self showDetailView];
    }
    
}
@end









