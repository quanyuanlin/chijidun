//
//  SearchHistoryResponse.h
//  chijidun
//
//  Created by iMac on 16/12/7.
//
//

#import <Foundation/Foundation.h>

@interface SearchHistoryResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@property(nonatomic,strong)NSArray *list;


@end
