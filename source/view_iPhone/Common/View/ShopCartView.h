//
//  ShopCartView.h
//  吃几顿
//
//  Created by iMac on 15/8/8.
//  Copyright (c) 2015年 杭州赚宝科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberTable.h"
@protocol shopCartViewDelegate <NSObject>

-(void)showCartView;
-(void)orderBtnClicked;

@end
@interface ShopCartView : UIView
{
    __weak id<shopCartViewDelegate> m_shopCartViewDelegate;
}
@property(nonatomic,weak) id<shopCartViewDelegate> p_shopCartViewDelegate;

-(void)setCartViewWith:(MemberTable *)item;
-(void)shopCartWith:(NSInteger)shopCount andPrice:(NSString *)price;

@property(nonatomic,strong)GlobalSettingResponse *response;
@property(nonatomic,weak)MemberTable *item;

-(void)setCartBtnWith:(BOOL)show;

@end
