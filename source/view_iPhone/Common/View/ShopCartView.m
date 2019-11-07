#import "ShopCartView.h"
#define CART_SIZE 50

@interface ShopCartView()
{
    UILabel *m_labPrice;
    UIImageView *m_cartButton;
    
    UILabel *m_labSelect;
    
    UIButton *m_btnCart;
    UIButton *m_btnSettle;
    
    UILabel *m_labCount;
    
    NSString *m_total;
    UILabel *m_labRange;
}
@end
@implementation ShopCartView
@synthesize p_shopCartViewDelegate=m_shopCartViewDelegate;

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews
{
    CGSize Size=self.frame.size;
    [self.layer addSublayer:getLine(0, kMainScreen_Width, 0, 0, BORDER_COLOR)];
    [self setBackgroundColor:WHITE_COLOR];
    
    m_cartButton=[[UIImageView alloc]initWithFrame:CGRectMake(2*kDistance, -CART_SIZE*2/5, CART_SIZE,  CART_SIZE)];
    m_cartButton.userInteractionEnabled=YES;
    [m_cartButton setImage:[UIImage imageNamed:@"icon-cart-nothing"]];
    [self addSubview:m_cartButton];
    [m_cartButton click:self action:@selector(showcartView:)];
    
    CGSize btnSize=m_cartButton.frame.size;
    m_labCount=[[UILabel alloc]initWithFrame:CGRectMake(btnSize.width-15, 0, 20, 20)];
    [m_labCount setBackgroundColor:[UIColor redColor]];
    [m_labCount setTextColor:WHITE_COLOR];
    [m_labCount setTextAlignment:NSTextAlignmentCenter];
    [m_labCount setFont:[UIFont LightFontOfSize:13]];
    m_labCount.layer.cornerRadius=10;
    m_labCount.layer.masksToBounds=YES;
    [m_labCount setHidden:YES];
    [m_cartButton addSubview:m_labCount];
    
    CGFloat orginX=CGRectGetMaxX(m_cartButton.frame)+kDistanceMin;
    m_labPrice=[[UILabel alloc]initWithFrame:CGRectMake(orginX, kDistanceMin, Size.width*0.4, 17)];
    [m_labPrice setTextColor:RED_COLOR];
    [m_labPrice setText:@"￥0.00"];
    [m_labPrice setFont:[UIFont FontOfSize:18]];
    [self addSubview:m_labPrice];
    
    m_labRange=[[UILabel alloc]initWithFrame:CGRectMake(orginX, CGRectGetMaxY(m_labPrice.frame)+5, Size.width*0.4, 10)];
    [m_labRange setFont:[UIFont LightFontOfSize:12]];
    [m_labRange setTextColor:TEXT_DEEP];
    [self addSubview:m_labRange];

    
    m_labSelect=[[UILabel alloc]initWithFrame:CGRectMake(Size.width-120, 0,120, Size.height)];
    [m_labSelect setTextAlignment:NSTextAlignmentCenter];
    [m_labSelect setTextColor:WHITE_COLOR];
    [m_labSelect setBackgroundColor:BORDER_COLOR];
    [m_labSelect setFont:[UIFont LightFontOfSize:17]];
    [m_labSelect setText:@"立即下单"];
    [self addSubview:m_labSelect];
    [m_labSelect click:self action:@selector(showcartView:)];
}
-(void)setCartViewWith:(MemberTable *)item
{
    self.item=item;
    [self setRestPriceWith:@"0"];
}
-(void)shopCartWith:(NSInteger)shopCount andPrice:(NSString *)price
{
    m_total=price;
    if (shopCount>0) {
        m_labCount.hidden=NO;
        [m_labCount setText:[NSString stringWithFormat:@"%ld",(long)shopCount]];
        [m_cartButton setImage:[UIImage imageNamed:@"icon-cart"]];
    }else{
        [m_labCount setText:[NSString stringWithFormat:@"%ld",(long)shopCount]];
        m_labCount.hidden=YES;
        [m_cartButton setImage:[UIImage imageNamed:@"icon-cart-nothing"]];
    }
    [m_labPrice setText:[NSString stringWithFormat:@"￥%@",price]];
    [self setRestPriceWith:price];
}
-(void)showcartView:(UIGestureRecognizer *)gesture
{
    if ([m_labCount.text intValue]>0) {
        if (gesture.view==m_labSelect) {
            if ([m_shopCartViewDelegate respondsToSelector:@selector(orderBtnClicked)]) {
                [m_shopCartViewDelegate orderBtnClicked];
            }
        }else if (gesture.view==m_cartButton) {
            if ([m_shopCartViewDelegate respondsToSelector:@selector(showCartView)]) {
                [m_shopCartViewDelegate showCartView];
            }
        }
        
    }
}
-(void)setRestPriceWith:(NSString *)price
{
    float money=[price intValue]-_response.free_shipping_money.intValue;
    NSString *express;
    if (money>=0) {
        express=@"满50元免配送费";
        [m_labRange setText:express];
    }else{
        express=[NSString stringWithFormat:@"配送费￥%@",_response.default_freight];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:express];
        [AttributedStr addAttribute:NSFontAttributeName
                              value:[UIFont FontOfSize:12]
                              range:NSMakeRange(0, 3)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:TEXT_LIGHT
                              range:NSMakeRange(0, 3)];
        m_labRange.attributedText = AttributedStr;
    }
  
    float restmoney=[self.item.min_price intValue]-[price floatValue];
    if (restmoney>0) {
        m_labSelect.userInteractionEnabled=NO;
        
        int t=(int)restmoney;
        NSString *total=[NSString stringWithFormat:@"%.1f",restmoney];
        if (restmoney==t) {
            total=[NSString stringWithFormat:@"%d",t];
        }
        [m_labSelect setText:[NSString stringWithFormat:@"差%@元起送",total]];
        [m_labSelect setBackgroundColor:BORDER_COLOR];
    }else{
        if (price.floatValue>0) {
            m_labSelect.userInteractionEnabled=YES;
            [m_labSelect setBackgroundColor:RED_COLOR];
            [m_labSelect setText:@"立即下单"];
            m_cartButton.userInteractionEnabled=YES;
        }else{
            m_labSelect.userInteractionEnabled=NO;
            [m_labSelect setBackgroundColor:BORDER_COLOR];
            [m_labSelect setText:@"立即下单"];
            m_cartButton.userInteractionEnabled=NO;
        }
        
    }
}
-(void)setCartBtnWith:(BOOL)show
{
    [m_cartButton setHidden:!show];
    
    CGFloat width=CART_SIZE+kDistance;
    if (show) {
        CGPoint point = m_labPrice.center;
        point.x += width;
        [m_labPrice setCenter:point];
        
        CGPoint point2 = m_labRange.center;
        point2.x += width;
        [m_labRange setCenter:point2];
        
        NSString *string=[NSString stringWithFormat:@"￥%@",m_total];
        [m_labPrice setText:string];
    }else{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        CGPoint point = m_labPrice.center;
        point.x -= width;
        [m_labPrice setCenter:point];
        
        CGPoint point2 = m_labRange.center;
        point2.x -= width;
        [m_labRange setCenter:point2];
        [UIView commitAnimations];
        
        NSString *string=[NSString stringWithFormat:@"￥%@",m_total];
        [m_labPrice setText:string];
    }
}
@end






