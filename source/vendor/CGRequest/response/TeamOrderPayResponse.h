//
//  TeamOrderPayResponse.h
//  chijidun
//
//  Created by iMac on 16/9/28.
//
//

#import <Foundation/Foundation.h>

@interface TeamOrderPayResponse : NSObject

@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)NSString *code;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;


@end
