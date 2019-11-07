/*
不要手动修改
*/
#import "ItemTable.h"

@implementation ItemTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.bimg = [self stringFormat:JSON[@"bimg"]];
    self.cart_num = [self stringFormat:JSON[@"cart_num"]];
    self.cate_id = [self stringFormat:JSON[@"cate_id"]];
    self.comments = [self stringFormat:JSON[@"comments"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.is_hots = [self stringFormat:JSON[@"is_hots"]];
    self.is_index = [self stringFormat:JSON[@"is_index"]];
    self.is_new = [self stringFormat:JSON[@"is_new"]];
    self.item_desc = [self stringFormat:JSON[@"item_desc"]];
    NSMutableArray *item_imgArray =[self arrayFormat:JSON[@"item_img"]];
    self.item_img=[NSMutableArray new];
    if (item_imgArray && item_imgArray.count > 0) {
        for (NSMutableDictionary *item in item_imgArray)
            [self.item_img addObject:[[[Item_imgTable alloc]init]fromJSON:item]];
    }   
    NSMutableArray *items_cateArray =[self arrayFormat:JSON[@"items_cate"]];
    self.level = [self stringFormat:JSON[@"level"]];
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.mname = [self stringFormat:JSON[@"mname"]];
    self.online = [self stringFormat:JSON[@"online"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.price = [self stringFormat:JSON[@"price"]];
    self.purchase_type = [self stringFormat:JSON[@"purchase_type"]];
    self.rates = [self stringFormat:JSON[@"rates"]];
    self.recommand_desc = [self stringFormat:JSON[@"recommand_desc"]];
    self.remain_stock = [self stringFormat:JSON[@"remain_stock"]];
    self.sales = [self stringFormat:JSON[@"sales"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.stime = [self stringFormat:JSON[@"stime"]];
    self.stock = [self stringFormat:JSON[@"stock"]];
    self.stock_perday = [self stringFormat:JSON[@"stock_perday"]];
    self.storage_label = [self stringFormat:JSON[@"storage_label"]];
    self.title = [self stringFormat:JSON[@"title"]];
    self.update_time = [self stringFormat:JSON[@"update_time"]];
    self.is_rice = [self stringFormat:JSON[@"is_rice"]];
    self.material = [self stringFormat:JSON[@"material"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.bimg!=nil){
        [res addObject:[self JSONItemFormat:@"\"bimg\":\"%@\"" data:self.bimg]];
    }
    if(self.cart_num!=nil){
        [res addObject:[self JSONItemFormat:@"\"cart_num\":\"%@\"" data:self.cart_num]];
    }
    if(self.cate_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"cate_id\":\"%@\"" data:self.cate_id]];
    }
    if(self.comments!=nil){
        [res addObject:[self JSONItemFormat:@"\"comments\":\"%@\"" data:self.comments]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.img!=nil){
        [res addObject:[self JSONItemFormat:@"\"img\":\"%@\"" data:self.img]];
    }
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.is_hots!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_hots\":\"%@\"" data:self.is_hots]];
    }
    if(self.is_index!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_index\":\"%@\"" data:self.is_index]];
    }
    if(self.is_new!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_new\":\"%@\"" data:self.is_new]];
    }
    if(self.item_desc!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_desc\":\"%@\"" data:self.item_desc]];
    }
    NSMutableArray *item_imgList = [NSMutableArray new];
        for (Item_imgTable *item in self.item_img)
            [item_imgList addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"item_img\":[%@]",[item_imgList componentsJoinedByString:@","]]];
    if(self.level!=nil){
        [res addObject:[self JSONItemFormat:@"\"level\":\"%@\"" data:self.level]];
    }
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    if(self.mname!=nil){
        [res addObject:[self JSONItemFormat:@"\"mname\":\"%@\"" data:self.mname]];
    }
    if(self.online!=nil){
        [res addObject:[self JSONItemFormat:@"\"online\":\"%@\"" data:self.online]];
    }
    if(self.ordid!=nil){
        [res addObject:[self JSONItemFormat:@"\"ordid\":\"%@\"" data:self.ordid]];
    }
    if(self.price!=nil){
        [res addObject:[self JSONItemFormat:@"\"price\":\"%@\"" data:self.price]];
    }
    if(self.purchase_type!=nil){
        [res addObject:[self JSONItemFormat:@"\"purchase_type\":\"%@\"" data:self.purchase_type]];
    }
    if(self.rates!=nil){
        [res addObject:[self JSONItemFormat:@"\"rates\":\"%@\"" data:self.rates]];
    }
    if(self.recommand_desc!=nil){
        [res addObject:[self JSONItemFormat:@"\"recommand_desc\":\"%@\"" data:self.recommand_desc]];
    }
    if(self.remain_stock!=nil){
        [res addObject:[self JSONItemFormat:@"\"remain_stock\":\"%@\"" data:self.remain_stock]];
    }
    if(self.sales!=nil){
        [res addObject:[self JSONItemFormat:@"\"sales\":\"%@\"" data:self.sales]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.stime!=nil){
        [res addObject:[self JSONItemFormat:@"\"stime\":\"%@\"" data:self.stime]];
    }
    if(self.stock!=nil){
        [res addObject:[self JSONItemFormat:@"\"stock\":\"%@\"" data:self.stock]];
    }
    if(self.stock_perday!=nil){
        [res addObject:[self JSONItemFormat:@"\"stock_perday\":\"%@\"" data:self.stock_perday]];
    }
    if(self.storage_label!=nil){
        [res addObject:[self JSONItemFormat:@"\"storage_label\":\"%@\"" data:self.storage_label]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    if(self.update_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"update_time\":\"%@\"" data:self.update_time]];
    }
    if(self.is_rice!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_rice\":\"%@\"" data:self.is_rice]];
    }
    if(self.material!=nil){
        [res addObject:[self JSONItemFormat:@"\"material\":\"%@\"" data:self.material]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end
