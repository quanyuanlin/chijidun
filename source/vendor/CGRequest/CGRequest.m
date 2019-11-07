//
//  CGRequest.m
//  ApiClient
//
//  Created by iMac on 16/7/27.
//  Copyright © 2016年 杭州赚宝科技有限公司. All rights reserved.
//

#import "CGRequest.h"

@implementation CGRequest
- (NSString *)paramString
{
    return [self paramStringWithParamDictionary:nil];
}

- (NSString *)paramStringWithParamObject:(id)paramObj
{
    return [self paramStringWithParamDictionary:((NSObject *)paramObj).mj_keyValues];
}

- (NSString *)paramStringWithParamDictionary:(NSDictionary *)paramDic;
{
    // 获取参数字典，拼接公共参数字典
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:paramDic];
    [dic setValuesForKeysWithDictionary:self.mj_keyValues];
    return [dic mj_JSONString];
}

@end
