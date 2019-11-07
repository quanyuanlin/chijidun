/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Score_itemTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *buy_num;
@property(strong, nonatomic) NSString *cate_id;
@property(strong, nonatomic) NSString *desc;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *img;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *score;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *stock;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *type;
@property(strong, nonatomic) NSString *user_num;

@end