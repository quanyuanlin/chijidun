//
//  UserAddressAddRequest.h
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import <Foundation/Foundation.h>

@interface UserAddressAddRequest : NSObject

@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *area;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *pos_lat;
@property(nonatomic,strong)NSString *pos_lng;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *tele;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *house_number;

@end
