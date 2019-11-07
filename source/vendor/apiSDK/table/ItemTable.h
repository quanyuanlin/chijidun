/*
不要手动修改
*/
#import <Foundation/Foundation.h>
#import "ApiBase.h"
#import "Item_imgTable.h"

@class Item_imgTable;
@class Member_shop_cateData;

@interface ItemTable : ApiBase
- (instancetype)fromJSON:(NSMutableDictionary *) data;
- (NSString *) toJSON;

@property(strong, nonatomic) NSString *add_time;
@property(strong, nonatomic) NSString *bimg;
@property(strong, nonatomic) NSString *cart_num;
@property(strong, nonatomic) NSString *cate_id;
@property(strong, nonatomic) NSString *comments;
@property(strong, nonatomic) NSString *Id;
@property(strong, nonatomic) NSString *img;
@property(strong, nonatomic) NSString *info;
@property(strong, nonatomic) NSString *is_hots;
@property(strong, nonatomic) NSString *is_index;
@property(strong, nonatomic) NSString *is_new;
@property(strong, nonatomic) NSString *item_desc;
@property(strong, nonatomic) NSMutableArray/*Item_imgTable*/ *item_img;
@property(strong, nonatomic) NSString *level;
@property(strong, nonatomic) NSString *mid;
@property(strong, nonatomic) NSString *mname;
@property(strong, nonatomic) NSString *online;
@property(strong, nonatomic) NSString *ordid;
@property(strong, nonatomic) NSString *price;
@property(strong, nonatomic) NSString *purchase_type;
@property(strong, nonatomic) NSString *rates;
@property(strong, nonatomic) NSString *recommand_desc;
@property(strong, nonatomic) NSString *remain_stock;
@property(strong, nonatomic) NSString *sales;
@property(strong, nonatomic) NSString *status;
@property(strong, nonatomic) NSString *stime;
@property(strong, nonatomic) NSString *stock;
@property(strong, nonatomic) NSString *stock_perday;
@property(strong, nonatomic) NSString *storage_label;
@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSString *update_time;

@property(strong, nonatomic) NSString *is_rice;
@property(strong, nonatomic) NSString *sum;
@property(strong, nonatomic) NSString *item_id;
@property(strong, nonatomic) NSString *material;



@end





