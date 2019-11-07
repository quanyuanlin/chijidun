//
//  CGResponse.h
//  LibraryDemo
//
//  Created by caochungui on 15/4/28.
//  Copyright (c) 2015年 mobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 响应结果参数(外层)
@interface CGResponse : NSObject

@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSString *code;

@end
