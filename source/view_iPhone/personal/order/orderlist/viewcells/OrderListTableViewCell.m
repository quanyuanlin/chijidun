#import "OrderListTableViewCell.h"

@implementation OrderListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titleLabel.userInteractionEnabled=YES;
    self.quantityLabel.textColor=TEXT_COLOR_DARK;
    self.subTitleLabel.textColor=TEXT_COLOR_DARK;
    
   // self.coverImageWith.constant=self.coverImage.frame.size.height*coverimagewidth;
}
- (void)bind
{
    @weakify(self)
    [RACObserve(self, cartItem)
     subscribeNext:^(id x) {
         @strongify(self);
         [self render];
     }];
}

- (void)unbind
{
}
- (void)render
{
    self.titleLabel.text = self.cartItem.goods_name;
    self.subTitleLabel.text= [NSString stringWithFormat:@"%@",!self.cartItem.goods_strattr?self.cartItem.goods_strattr:@"家常菜"];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",
                       self.cartItem.goods_price];
    
    self.quantityLabel.text=[NSString stringWithFormat:@"x%ld",(long)self.cartItem.goods_number];
    [self.coverImage loadImage:self.cartItem.img.small placeHolder:img_placehold_small];
}


@end
