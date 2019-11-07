//
//  GlobalSettingResponse.h
//  chijidun
//
//  Created by iMac on 16/10/28.
//
//

#import <Foundation/Foundation.h>

@interface GlobalSettingResponse : NSObject

@property(nonatomic,strong)NSString *default_freight;
@property(nonatomic,strong)NSString *free_shipping_money;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;


@end
