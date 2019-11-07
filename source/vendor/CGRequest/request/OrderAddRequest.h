//
//  OrderAddRequest.h
//  chijidun
//
//  Created by iMac on 16/10/31.
//
//

#import <Foundation/Foundation.h>

@interface OrderAddRequest : NSObject

@property(nonatomic,strong)NSString *pays;
@property(nonatomic,strong)NSString *score;
@property(nonatomic,strong)NSString *address_id;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSString *days;
@property(nonatomic,strong)NSString *times;
@property(nonatomic,strong)NSString *express;
@property(nonatomic,strong)NSString *quan_id;
@property(nonatomic,strong)NSString *items;
@property(nonatomic,strong)NSString *mid;

@end
