/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Item_favsTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *item_favs;
@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *item_title;
@property(strong, nonatomic) NSString *m_favs;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *mname;
@property(strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *uname;

@end