//
//  MemberSearchRequest.h
//  chijidun
//
//  Created by iMac on 16/12/8.
//
//

#import <Foundation/Foundation.h>

@interface MemberSearchRequest : NSObject

@property(nonatomic,strong)NSString *key;
@property(nonatomic,strong)NSString *page;
@property(nonatomic,strong)NSString *perPage;
@property(nonatomic,strong)NSString *pos_lat;
@property(nonatomic,strong)NSString *pos_lng;
@property(nonatomic,strong)NSString *city;

@end
