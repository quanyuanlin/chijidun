//
//  CGRequest.h
//  ApiClient
//
//  Created by iMac on 16/7/27.
//  Copyright © 2016年 杭州赚宝科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGRequest : NSObject

@property(nonatomic,strong) NSString *token;


/**
 *  @brief  转化参数字符串(不带入参)
 *
 *  @return
 */
- (NSString *)paramString;

/**
 *  @brief  转化参数字符串
 *
 *  @param  paramObj  参数对象
 *
 *  @return
 */
- (NSString *)paramStringWithParamObject:(id)paramObj;

/**
 *  @brief  转化参数字符串
 *
 *  @param  paramDic  参数字典
 *
 *  @return
 */
- (NSString *)paramStringWithParamDictionary:(NSDictionary *)paramDic;


@end
