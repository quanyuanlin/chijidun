/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Member_cardTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *card_id;
@property(strong, nonatomic) NSString *card_no;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *is_default;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *real_fname;
@property(strong, nonatomic) NSString *real_name;

@end