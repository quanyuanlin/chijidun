//
//  UserAddressTable.h
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import <Foundation/Foundation.h>

@interface UserAddressTable : NSObject

@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *uname;
@property(strong, nonatomic) NSString *province;
@property(strong, nonatomic) NSString *city;
@property(strong, nonatomic) NSString *area;
@property(strong, nonatomic) NSString *province_id;
@property(strong, nonatomic) NSString *city_id;
@property(strong, nonatomic) NSString *area_id;
@property(strong, nonatomic) NSString *address;
@property(strong, nonatomic) NSString *zipcode;
@property(strong, nonatomic) NSString *pos_lng;
@property(strong, nonatomic) NSString *pos_lat;
@property(strong, nonatomic) NSString *tele;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *remark;
@property(strong, nonatomic) NSString *is_default;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic)  NSString *country;
@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *sex;
@property(strong, nonatomic) NSString *house_number;
@property(strong, nonatomic) NSDictionary *user;
@property(strong, nonatomic) NSString *selectable;
@property(strong, nonatomic) NSString *distance;
@property(strong, nonatomic) NSString *need_complete;
@property(strong, nonatomic)  NSString *checked;

@end
