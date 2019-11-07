//
//  UserAddressListsRequest.h
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import <Foundation/Foundation.h>

@interface UserAddressListsRequest : NSObject

@property(nonatomic,strong)NSString *page;
@property(nonatomic,strong)NSString *perPage;
@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)NSString *user_lng;
@property(nonatomic,strong)NSString *user_lat;
@property(nonatomic,strong)NSString *chef_lng;
@property(nonatomic,strong)NSString *chef_lat;
@property(nonatomic,strong)NSString *chef_distance;

@property(nonatomic,strong)NSString *hide;

@end
