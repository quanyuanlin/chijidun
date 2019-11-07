//
//  TConfig.m
//  btc
//
//  Created by txj on 15/1/25.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "TConfig.h"

@implementation TConfig
+ (instancetype)shared
{
    static TConfig *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}
@end
