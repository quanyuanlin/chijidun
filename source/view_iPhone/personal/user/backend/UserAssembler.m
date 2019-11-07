//
//  UserAssembler.m
//  insuny
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "UserAssembler.h"

@implementation UserAssembler
#pragma Grade//品位

- (NSArray *)gradeAddListWithJSON:(NSArray *)JSON {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSDictionary *item in JSON)
        [items addObject:[self gradeWithJSON:item withType:0]];
    return items;
}

- (NSArray *)gradeListWithJSON:(NSArray *)JSON {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSDictionary *item in JSON)
        [items addObject:[self gradeWithJSON:item withType:1]];
    return items;
}

- (CATEGORY *)gradeWithJSON:(NSDictionary *)JSON withType:(NSInteger)type {
    CATEGORY *grade = [[CATEGORY alloc] init];
    if (type == 1) {
        NSMutableArray *children;
        NSArray *childrenJSON = [JSON objectForKey:@"items"];
        if (childrenJSON && childrenJSON.count > 0) {
            children = [[NSMutableArray alloc] initWithCapacity:childrenJSON.count];
            for (NSDictionary *childJSON in childrenJSON)
                [children addObject:[self gradeWithJSON:childJSON withType:0]];
        }
        grade.children = children;
    }
    grade.rec_id = [JSON objectForKey:@"id"];
    grade.name = [JSON objectForKey:@"name"];
    grade.img.small = [JSON objectForKey:@"img"];

    return grade;
}

#pragma UserInfomation

- (NSArray *)userCouponList:(NSArray *)goodslistJSON; {
    NSMutableArray *products = [NSMutableArray arrayWithCapacity:goodslistJSON.count];

    for (NSDictionary *goodsJson in goodslistJSON)
        [products addObject:[self coupon:goodsJson]];

    return products;
}

- (COLLECT_GOODS *)coupon:(NSDictionary *)JSON {
    COLLECT_GOODS *goods = [[COLLECT_GOODS alloc] init];
    goods.name = [JSON objectForKey:@"title"];
    goods.shop_name = [JSON objectForKey:@"man_price"];
    goods.sub_title1 = [JSON objectForKey:@"title"];
    goods.sub_title2 = [JSON objectForKey:@"etime"];
    //    goods.goods_id=[JSON objectForKey:@"item_id"];
    goods.shop_price = [JSON objectForKey:@"price"];
    goods.rec_id = [JSON objectForKey:@"id"];
    goods.img.small = [JSON objectForKey:@"img"];

    return goods;
}

#pragma UserLogin

- (AccessToken *)accessToken:(NSDictionary *)anTokenJson; {
    AccessToken *accessToken = nil;
    if (anTokenJson != nil) {
        accessToken = [[AccessToken alloc] init];
        accessToken.accessToken = anTokenJson[@"token"];
        accessToken.userid = anTokenJson[@"id"];
    }

    return accessToken;
}

- (USER *)user:(NSDictionary *)anUser; {
    USER *user = nil;
    if (anUser != nil) {
        user = [[USER alloc] init];
        user.email = anUser[@"email"];
        user.tele = anUser[@"tele"];
        user.name = anUser[@"username"];
        user.sex = anUser[@"sex"];
        user.birthday = anUser[@"birthday"];
        user.intro = anUser[@"intro"];
        user.avatarimg = anUser[@"img"];
        user.msg_express = anUser[@"msg_express"];
        user.msg_sales = anUser[@"msg_sales"];
        user.msg_sys = anUser[@"msg_sys"];
        user.order_fahuo = anUser[@"order_fahuo"];
        user.order_fukuan = anUser[@"order_fukuan"];
        user.order_shouhuo = anUser[@"order_shouhuo"];
        user.coupon_num = anUser[@"quan"];
        user.score = anUser[@"score"];
        user.user_id = anUser[@"id"];
        user.token = anUser[@"token"];
        user.rank_level = anUser[@"level"];
        user.weibo = anUser[@"is_weibo_bind"];
        user.weixin = anUser[@"is_weixin_bind"];
        user.qq = anUser[@"is_qq_bind"];
        user.coupon_num = anUser[@"quans"];
        user.provence = anUser[@"province"];
        user.city = anUser[@"city"];
        user.area = anUser[@"area"];
    }
    return user;
}

@end
