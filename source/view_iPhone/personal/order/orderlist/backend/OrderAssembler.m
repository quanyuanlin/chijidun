//
//  OrderAssembler.m
//  insuny
//
//  Created by txj on 15/5/18.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "OrderAssembler.h"

@implementation OrderAssembler
- (NSArray *)ordersWithJSON:(NSArray *)JSON {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSDictionary *item in JSON)
        [items addObject:[self orderWithJSON:item]];
    return items;
}

- (ORDER *)orderWithJSON:(NSDictionary *)JSON {
    ORDER *od = [[ORDER alloc] init];
    od.rec_id = JSON[@"id"];
    od.order_info.order_id = JSON[@"orderid"];
    od.order_info.order_time = JSON[@"add_time"];
    od.order_info.pay_time = JSON[@"pays_time"];
    od.order_info.pays_id = JSON[@"pays_id"];
    od.order_info.check_time = JSON[@"check_time"];
    od.formated_shipping_fee = JSON[@"express"];
    od.order_info.order_id = JSON[@"orderid"];
    od.order_info.pay_code = JSON[@"pays_sn"];
    od.order_info.total_fee = JSON[@"total"];
    od.order_info.htotal = JSON[@"htotal"];
    od.order_info.order_status = JSON[@"status"];
    od.order_info.left_time=JSON[@"left_time"];
    
    od.order_info.pays = JSON[@"pays"];
    od.order_info.express_tele = JSON[@"express_tele"];
    od.order_info.remark = JSON[@"remark"];
    od.order_info.days = JSON[@"days"];
    od.order_info.times = JSON[@"times"];
    od.order_info.express_type = JSON[@"express_type"];
    od.formated_bonus=JSON[@"quan_price"];
    
    od.order_info.order_sstatus = [self getOrderSStatus:[NSString stringWithFormat:@"%ld", (long)[od.order_info.order_status integerValue]]];

    od.order_info.member_title = JSON[@"member_title"];
    od.order_info.member_id = JSON[@"mid"];
    od.order_info.member_tele=JSON[@"member_tele"];
    od.order_info.is_check = JSON[@"is_check"];
    od.shop_item = [self shopItem:JSON[@"items"]];
    od.shop_item.name = JSON[@"shop_title"];

    od.address_item.address = JSON[@"addr_address"];
    od.address_item.province_name = JSON[@"addr_province"];
    od.address_item.city_name = JSON[@"addr_city"];
    od.address_item.district_name = JSON[@"addr_area"];
    od.address_item.consignee = JSON[@"addr_name"];
    od.address_item.zipcode = JSON[@"addr_zipcode"];
    od.address_item.tel = JSON[@"addr_tele"];

    od.shipping_item.shipping_desc = JSON[@"express_remark"];
    od.shipping_item.shipping_code = JSON[@"express_code"];
    od.shipping_item.shipping_sn = JSON[@"express_sn"];
    od.shipping_item.shipping_name = JSON[@"express_name"];
    od.shipping_item.shipping_time = JSON[@"express_time"];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    od.shipping_item.shipping_time = currentDateStr;
    return od;
}

- (NSString *)getOrderSStatus:(NSString *)status {
    if ([status isEqualToString:@"0"]) {
        return @"待付款";
    }
    else if ([status isEqualToString:@"1"]) {
        return @"待接单";
    }
    else if ([status isEqualToString:@"2"]) {
        return @"待配送";
    }
    else if ([status isEqualToString:@"3"]) {
        return @"待确认";
    }
    else if ([status isEqualToString:@"4"]) {
        return @"待评价";
    }
    else if ([status isEqualToString:@"5"]) {
        return @"已评价";
    }
    else if ([status isEqualToString:@"6"] || [status isEqualToString:@"7"]) {
        return @"已完成";
    }
    else if ([status isEqualToString:@"8"]) {
        return @"已退款";
    }
    else if ([status isEqualToString:@"10"]) {
        return @"退款处理中";
    }
    else if ([status isEqualToString:@"11"]) {
        return @"已拒单";
    }
    return @"已关闭";
}

- (NSArray *)shopItemsWithJSON:(NSArray *)JSON {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSDictionary *item in JSON)
        [items addObject:[self shopItem:item]];
    return items;
}

- (SHOP_ITEM *)shopItem:(NSDictionary *)Json {
    SHOP_ITEM *item = [SHOP_ITEM new];
    item.cart_goods_list =[self cartGoodsList:Json];
    return item;
}

- (NSMutableArray *)cartGoodsList:(NSArray *)JSON {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSDictionary *item in JSON)
        [items addObject:[self cartGoods:item]];
    return items;
}

- (CART_GOODS *)cartGoods:(NSDictionary *)Json {
    CART_GOODS *cd = [CART_GOODS new];
    @try {
        cd.goods_name = [Json objectForKey:@"title"];
        cd.img.small = [Json objectForKey:@"item_img"];
        cd.goods_price = [[Json objectForKey:@"price"] floatValue];
        cd.goods_number = [[Json objectForKey:@"num"] integerValue];
        cd.goods_strattr = [Json objectForKey:@"attr"];
    } @catch (NSException *e) {}
    return cd;
}
@end
