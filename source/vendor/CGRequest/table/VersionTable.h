//
//  VersionTable.h
//  chijidun
//
//  Created by iMac on 16/9/2.
//
//

#import <Foundation/Foundation.h>

@interface VersionTable : NSObject

@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *content;
@property(strong, nonatomic) NSString *version;
@property(strong, nonatomic) NSString *up_version;
@property(strong, nonatomic) NSString *url;
@property(strong, nonatomic) NSString *os;
@property(strong, nonatomic) NSString *force;
@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *update_time;
@property(strong, nonatomic) NSString *app_type;
@property(strong, nonatomic) NSString *startup_img;
@property(strong, nonatomic) NSString *show_time;
@property(strong, nonatomic) NSString *end_time;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *img_link;
@property(strong, nonatomic) NSString *startup_default_img;
@property(strong, nonatomic) NSString *show_type;
@property(strong, nonatomic)  NSString *img_title;


@end
