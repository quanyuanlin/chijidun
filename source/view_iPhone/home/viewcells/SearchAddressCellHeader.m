//
//  SearchAddressCellHeader.m
//  chijidun
//
//  Created by iMac on 16/12/7.
//
//

#import "SearchAddressCellHeader.h"

@interface SearchAddressCellHeader ()
{
    UIButton *_button;
}
@end
@implementation SearchAddressCellHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.labTitle setFont:[UIFont LightFontOfSize:12]];
    [self.labTitle setTextColor:TEXT_LIGHT];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bindWith:(NSInteger)index
{
    NSArray *array=@[@"当前地址",@"我的收货地址",@"附近地址"];
    [self.labTitle setText:array[index]];
    
    if (_button==nil) {
        _button=[[UIButton alloc]initWithFrame:CGRectMake(kMainScreen_Width-90, 10, 75, 30)];
        [_button.titleLabel setFont:[UIFont LightFontOfSize:13]];
        [_button setTitleColor:RED_COLOR forState:UIControlStateNormal];
        [_button setImageEdgeInsets:UIEdgeInsetsMake(18, 0, 0, 62)];
        [_button setTitleEdgeInsets:UIEdgeInsetsMake(18, -17, 0, -10)];
    }
    [self.contentView addSubview:_button];
    
    if (index==0) {
        _button.hidden=NO;
        
        [_button setImage:[UIImage imageNamed:@"address_refresh"] forState:UIControlStateNormal];
        [_button setTitle:@"重新定位" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(clickCurrent:) forControlEvents:UIControlEventTouchUpInside];
       
    }else if (index==1){
        _button.hidden=NO;
        [_button setImage:[UIImage imageNamed:@"address_add"] forState:UIControlStateNormal];
        [_button setTitle:@"新增地址" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(clickAdd:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (index==2){
        _button.hidden=YES;
        
    }
    
}
-(void)clickCurrent:(UIButton *)button
{
    CABasicAnimation *radarRotation = [CABasicAnimation animation];
    radarRotation.keyPath = @"transform.rotation";
    radarRotation.toValue = @(2 * M_PI);
    radarRotation.duration = 0.7;
    radarRotation.repeatCount = MAXFLOAT;
    radarRotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [button.imageView.layer addAnimation:radarRotation forKey:@"radarRotation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.clickCurrentBlock) {
            self.clickCurrentBlock();
        }
    });
    
}
-(void)clickAdd:(UIButton *)button
{
    if (self.clickAddBlock) {
        self.clickAddBlock();
    }
}

@end
