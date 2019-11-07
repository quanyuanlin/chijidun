//
//  UserAddressAutoRequest.h
//  chijidun
//
//  Created by iMac on 16/11/17.
//
//

#import <Foundation/Foundation.h>

@interface UserAddressAutoRequest : NSObject

@property(nonatomic,strong)NSString *user_lat;
@property(nonatomic,strong)NSString *user_lng;
@property(nonatomic,strong)NSString *chef_lat;
@property(nonatomic,strong)NSString *chef_lng;
@property(strong, nonatomic)NSString *chef_distance;

@end
