//
//  SaveOrderResponse.h
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import <Foundation/Foundation.h>

@interface SaveOrderResponse : NSObject

@property(nonatomic,strong)NSString *code; //下单成功但未支付 210 下单成功不需要支付 200
@property(nonatomic,strong)NSString *Id;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;


@end
