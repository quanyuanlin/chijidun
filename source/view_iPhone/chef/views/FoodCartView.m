#import "FoodCartView.h"
#define CartTableCell @"TeamCartCell"

#define BtnCartSize 50
#define LabCartSize 22
@interface FoodCartView ()
{
    UIView *m_backView;
    UITableView *m_tableView;
    
    UIButton *m_buttonClear;
    UILabel *m_labCart;
    
    CGFloat H;
}
@end
@implementation FoodCartView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviewsWith:frame.size];
    }
    return self;
}

-(void)addSubviewsWith:(CGSize)sizeView
{
    UIView *view=[[UIView alloc]initWithFrame:self.bounds];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.6];
    [self addSubview:view];
    [view click:self action:@selector(removeView)];
    
    H=H(self)*0.5;
    m_backView=[[UIView alloc]initWithFrame:CGRectMake(0, H(self)*0.5, kMainScreen_Width, H(self)*0.5)];
    [m_backView setBackgroundColor:WHITE_COLOR];
    [self addSubview:m_backView];
    UIImageView *triView=[[UIImageView alloc]initWithFrame:CGRectMake(32, -11, 16, 16)];
    [triView setImage:[UIImage imageNamed:@"icon_triangle"]];
    [m_backView addSubview:triView];
    
    UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreen_Width, kCellHeight)];
    [header.layer addSublayer:getLine(0, kMainScreen_Width, kCellHeight, kCellHeight, getUIColor(0xdddddd))];
    [m_backView addSubview:header];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(kDistance, 13, 2, 14)];
    [label1 setBackgroundColor:getUIColor(0xff5436)];
    [header addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame)+10, 0, 75, kCellHeight)];
    [label2 setFont:[UIFont LightFontOfSize:17]];
    [label2 setTextColor:getUIColor(0x333333)];
    [label2 setText:@"购物车"];
    [header addSubview:label2];
    
    m_buttonClear=[[UIButton alloc]initWithFrame:CGRectMake(kMainScreen_Width-kDistance-83, 0, 83, 40)];
    [m_buttonClear setTitle:@"清空购物车" forState:UIControlStateNormal];
    [m_buttonClear setTitleColor:getUIColor(0x666666) forState:UIControlStateNormal];
    [m_buttonClear setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [m_buttonClear.titleLabel setFont:[UIFont LightFontOfSize:13]];
    [m_buttonClear setImage:[UIImage imageNamed:@"icon-del"] forState:UIControlStateNormal];
    [m_buttonClear addTarget:self action:@selector(removeCartlist:) forControlEvents:UIControlEventTouchUpInside];
    [m_buttonClear setImageEdgeInsets:UIEdgeInsetsMake(13, 0, 13, 70)];
    [m_buttonClear setTitleEdgeInsets:UIEdgeInsetsMake(0, -13, 0, 0)];
    [header addSubview:m_buttonClear];
    
    
    _btnCart=[[UIButton alloc]initWithFrame:CGRectMake(kDistance, -BtnCartSize-11, BtnCartSize, BtnCartSize)];
    [_btnCart setImage:[UIImage imageNamed:@"icon-cart"] forState:UIControlStateNormal];
    [m_backView addSubview:_btnCart];
    m_labCart=[[UILabel alloc]initWithFrame:CGRectMake(BtnCartSize-LabCartSize+5, -3, LabCartSize, LabCartSize)];
    [m_labCart setBackgroundColor:getUIColor(0xff0000)];
    [m_labCart setTextColor:WHITE_COLOR];
    m_labCart.layer.cornerRadius=LabCartSize/2;
    m_labCart.layer.masksToBounds=YES;
    [m_labCart setTextAlignment:NSTextAlignmentCenter];
    [m_labCart setFont:[UIFont FontOfSize:15]];
    [_btnCart addSubview:m_labCart];
    [_btnCart addTarget:self action:@selector(showCartView) forControlEvents:UIControlEventTouchUpInside];
    
    
    m_tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, kCellHeight, kMainScreen_Width, H(m_backView)-kCellHeight)];
    m_tableView.delegate=self;
    m_tableView.dataSource=self;
    [m_backView addSubview:m_tableView];
    [m_tableView registerNib:[UINib nibWithNibName:CartTableCell bundle:nil] forCellReuseIdentifier:CartTableCell];
}

-(void)showCartView
{
    
}
-(void)removeCartlist:(UIButton *)button
{
    CBWAlertView *view = [[CBWAlertView alloc]initWithTitle:@"确定清空？" andMessage:nil];
    view.animationType = AnimationTypeBigToSmall;
    view.titleTextColor = TEXT_DEEP;
    
    [view addButtonWithTitle:@"取消" color:BLUE_COLOR handler:^(CBWAlertView *alertView){
    }];
    [view addButtonWithTitle:@"确定" color:BLUE_COLOR handler:^(CBWAlertView *alertView) {
        [self removeFromSuperview];
        self.deleteBlock();
    }];
    [view show];
}
-(void)removeView
{
    [self removeFromSuperview];
    self.removeBlock();
}
#pragma mark tableview datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cartList.count;
}
#pragma mark tableview delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamCartCell *cell = (TeamCartCell *)[tableView dequeueReusableCellWithIdentifier:CartTableCell forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell bindItemWith:_cartList[indexPath.row]];
    cell.isPersonnal=YES;
    __block __typeof(self)weakSelf = self;
    cell.changeBlock = ^(ItemTable *item,int count){
        item.cart_num=[NSString stringWithFormat:@"%d",count];
        for (ItemTable *table in _cartList) {
            if ([table.Id isEqualToString:item.Id]) {
                if (count>0) {
                    table.cart_num=item.cart_num;
                    break;
                }else{
                    if (table.is_rice.intValue==0) {
                        [_cartList removeObject:table];
                    }                    
                    break;
                }
            }
        }
        [weakSelf reloadCartTable:NO];
        self.changeBlock(item);
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)reloadCartTable:(BOOL)animated
{
    CGFloat height=_cartList.count*60+kCellHeight;
    if (_cartList.count==0) {
        [self removeView];
        return;
    }else if (_cartList.count==1){
        ItemTable *item=_cartList[0];
        if (item.is_rice.intValue==1&&item.cart_num.intValue==0) {
            [self removeView];
            return;
        }
    }
    if (height>H) {
        height=H;
        m_tableView.scrollEnabled=YES;
    }else{
        m_tableView.scrollEnabled=NO;
    }
    
    if (animated) {
        [m_backView setFrame:CGRectMake(0, H(self)-kCellHeight, kMainScreen_Width, kCellHeight)];
        [m_tableView setFrame:CGRectMake(0, kCellHeight, kMainScreen_Width, 0)];
        [UIView animateWithDuration:0.5 animations:^{
            [m_backView setFrame:CGRectMake(0, H(self)-height, kMainScreen_Width, height)];
            [m_tableView setFrame:CGRectMake(0, kCellHeight, kMainScreen_Width, height-kCellHeight)];
        } completion:^(BOOL finished) {
        }];
    }else{
        [m_backView setFrame:CGRectMake(0, H(self)-height, kMainScreen_Width, height)];
        [m_tableView setFrame:CGRectMake(0, kCellHeight, kMainScreen_Width, height-kCellHeight)];
    }

    
    [m_tableView reloadData];
    
    int total=0;
    float totalMoney=0;
    for (ItemTable *item in _cartList) {
        totalMoney=totalMoney+item.cart_num.intValue*item.price.floatValue;
        total=total+item.cart_num.intValue;
    }
    [m_labCart setText:[NSString stringWithFormat:@"%d",total]];
//    NSString *money=[NSString stringWithFormat:@"共￥%.2f",totalMoney];
//    self.changeBlock(money,_cartList);
}


@end







