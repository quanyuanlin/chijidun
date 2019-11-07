/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Ad_appTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *link_url;
@property(strong, nonatomic) NSString *share_desc;
@property(strong, nonatomic) NSString *share_icon;
@property(strong, nonatomic) NSString *share_title;
@property(strong, nonatomic) NSString *share_url;
@property(strong, nonatomic) NSString *banner_img;

@end
