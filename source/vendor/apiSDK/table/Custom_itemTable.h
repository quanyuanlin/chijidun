/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"


@interface Custom_itemTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *abst;
@property(strong, nonatomic) NSString *fruit;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *img;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *meat;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *orders;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *price;
@property(strong, nonatomic) NSString *soup;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *vege;

@end