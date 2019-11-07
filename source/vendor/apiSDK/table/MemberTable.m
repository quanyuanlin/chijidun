/*
不要手动修改
*/
#import "MemberTable.h"

@implementation MemberTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.address = [self stringFormat:JSON[@"address"]];
    self.admin_id = [self stringFormat:JSON[@"admin_id"]];
    self.area = [self stringFormat:JSON[@"area"]];
    self.area_id = [self stringFormat:JSON[@"area_id"]];
    self.birthday = [self stringFormat:JSON[@"birthday"]];
    self.caixi = [self stringFormat:JSON[@"caixi"]];
    self.card_bg = [self stringFormat:JSON[@"card_bg"]];
    self.card_fr = [self stringFormat:JSON[@"card_fr"]];
    self.city = [self stringFormat:JSON[@"city"]];
    self.city_id = [self stringFormat:JSON[@"city_id"]];
    self.comment_num = [self stringFormat:JSON[@"comment_num"]];
    NSMutableArray *coversArray =[self arrayFormat:JSON[@"covers"]];
    self.covers=[NSMutableArray new];
    if (coversArray && coversArray.count > 0) {
        for (NSMutableDictionary *item in coversArray)
            [self.covers addObject:[[[Member_imgTable alloc]init]fromJSON:item]];
    }   
    self.deviceid = [self stringFormat:JSON[@"deviceid"]];
    self.email = [self stringFormat:JSON[@"email"]];
    self.etime = [self stringFormat:JSON[@"etime"]];
    self.fahuo_address = [self stringFormat:JSON[@"fahuo_address"]];
    self.favs = [self stringFormat:JSON[@"favs"]];
    self.health = [self stringFormat:JSON[@"health"]];
    NSMutableArray *hotArray =[self arrayFormat:JSON[@"hot_items"]];
    self.hot_items=[NSMutableArray new];
    if (hotArray && hotArray.count > 0) {
        for (NSMutableDictionary *item in hotArray)
            [self.hot_items addObject:[[[Hot_itemData alloc]init]fromJSON:item]];
    }
    self.Id = [self stringFormat:JSON[@"id"]];
    self.idcard = [self stringFormat:JSON[@"idcard"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.is_check = [self stringFormat:JSON[@"is_check"]];
    self.is_member_favs = [self stringFormat:JSON[@"is_member_favs"]];
    self.is_open = [self stringFormat:JSON[@"is_open"]];
    self.is_take = [self stringFormat:JSON[@"is_take"]];
    NSMutableArray *itemsArray =[self arrayFormat:JSON[@"items"]];
    self.items=[NSMutableArray new];
    if (itemsArray && itemsArray.count > 0) {
        for (NSMutableDictionary *item in itemsArray)
            [self.items addObject:[[[ItemTable alloc]init]fromJSON:item]];
    }   
    self.last_dev = [self stringFormat:JSON[@"last_dev"]];
    self.last_ip = [self stringFormat:JSON[@"last_ip"]];
    self.last_lat = [self stringFormat:JSON[@"last_lat"]];
    self.last_lng = [self stringFormat:JSON[@"last_lng"]];
    self.last_sys = [self stringFormat:JSON[@"last_sys"]];
    self.last_time = [self stringFormat:JSON[@"last_time"]];
    self.likes = [self stringFormat:JSON[@"likes"]];
    NSMutableArray *member_imgArray =[self arrayFormat:JSON[@"member_img"]];
    self.member_img=[NSMutableArray new];
    if (member_imgArray && member_imgArray.count > 0) {
        for (NSMutableDictionary *item in member_imgArray)
            [self.member_img addObject:[[[Member_imgTable alloc]init]fromJSON:item]];
    }   
    self.min_price = [self stringFormat:JSON[@"min_price"]];
    self.min_range = [self stringFormat:JSON[@"min_range"]];
    self.money = [self stringFormat:JSON[@"money"]];
    self.mosaic_card = [self stringFormat:JSON[@"mosaic_card"]];
    self.mosaic_health = [self stringFormat:JSON[@"mosaic_health"]];
    self.notice = [self stringFormat:JSON[@"notice"]];
    self.order_capability = [self stringFormat:JSON[@"order_capability"]];
    self.orders = [self stringFormat:JSON[@"orders"]];
    self.sales = [self stringFormat:JSON[@"sales"]];
    self.password = [self stringFormat:JSON[@"password"]];
    self.phone = [self stringFormat:JSON[@"phone"]];
    self.pos_lat = [self stringFormat:JSON[@"pos_lat"]];
    self.pos_lng = [self stringFormat:JSON[@"pos_lng"]];
    self.province = [self stringFormat:JSON[@"province"]];
    self.province_id = [self stringFormat:JSON[@"province_id"]];
    self.reg_dev = [self stringFormat:JSON[@"reg_dev"]];
    self.reg_ip = [self stringFormat:JSON[@"reg_ip"]];
    self.reg_time = [self stringFormat:JSON[@"reg_time"]];
    self.score = [self stringFormat:JSON[@"score"]];
    self.service_capability = [self stringFormat:JSON[@"service_capability"]];
    self.sex = [self stringFormat:JSON[@"sex"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.statusStr = [self stringFormat:JSON[@"statusStr"]];
    self.stime = [self stringFormat:JSON[@"stime"]];
    self.tele = [self stringFormat:JSON[@"tele"]];
    self.title = [self stringFormat:JSON[@"title"]];
    self.total = [self stringFormat:JSON[@"total"]];
    self.town = [self stringFormat:JSON[@"town"]];
    self.username = [self stringFormat:JSON[@"username"]];
    self.weeks = [self stringFormat:JSON[@"weeks"]];
    self.distance = [self stringFormat:JSON[@"distance"]];
    self.hometown = [self stringFormat:JSON[@"hometown"]];
    self.statusTomorrow = [self stringFormat:JSON[@"statusTomorrow"]];
    self.statusDistance = [self stringFormat:JSON[@"statusDistance"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.address!=nil){
        [res addObject:[self JSONItemFormat:@"\"address\":\"%@\"" data:self.address]];
    }
    if(self.admin_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"admin_id\":\"%@\"" data:self.admin_id]];
    }
    if(self.area!=nil){
        [res addObject:[self JSONItemFormat:@"\"area\":\"%@\"" data:self.area]];
    }
    if(self.area_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"area_id\":\"%@\"" data:self.area_id]];
    }
    if(self.birthday!=nil){
        [res addObject:[self JSONItemFormat:@"\"birthday\":\"%@\"" data:self.birthday]];
    }
    if(self.caixi!=nil){
        [res addObject:[self JSONItemFormat:@"\"caixi\":\"%@\"" data:self.caixi]];
    }
    if(self.card_bg!=nil){
        [res addObject:[self JSONItemFormat:@"\"card_bg\":\"%@\"" data:self.card_bg]];
    }
    if(self.card_fr!=nil){
        [res addObject:[self JSONItemFormat:@"\"card_fr\":\"%@\"" data:self.card_fr]];
    }
    if(self.city!=nil){
        [res addObject:[self JSONItemFormat:@"\"city\":\"%@\"" data:self.city]];
    }
    if(self.city_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"city_id\":\"%@\"" data:self.city_id]];
    }
    if(self.comment_num!=nil){
        [res addObject:[self JSONItemFormat:@"\"comment_num\":\"%@\"" data:self.comment_num]];
    }
    NSMutableArray *coversList = [NSMutableArray new];
        for (Member_imgTable *item in self.covers)
            [coversList addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"covers\":[%@]",[coversList componentsJoinedByString:@","]]];
    if(self.deviceid!=nil){
        [res addObject:[self JSONItemFormat:@"\"deviceid\":\"%@\"" data:self.deviceid]];
    }
    if(self.email!=nil){
        [res addObject:[self JSONItemFormat:@"\"email\":\"%@\"" data:self.email]];
    }
    if(self.etime!=nil){
        [res addObject:[self JSONItemFormat:@"\"etime\":\"%@\"" data:self.etime]];
    }
    if(self.fahuo_address!=nil){
        [res addObject:[self JSONItemFormat:@"\"fahuo_address\":\"%@\"" data:self.fahuo_address]];
    }
    if(self.favs!=nil){
        [res addObject:[self JSONItemFormat:@"\"favs\":\"%@\"" data:self.favs]];
    }
    if(self.health!=nil){
        [res addObject:[self JSONItemFormat:@"\"health\":\"%@\"" data:self.health]];
    }
    NSMutableArray *hotsList = [NSMutableArray new];
    for (Hot_itemData *item in self.hot_items)
        [hotsList addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"hot_items\":[%@]",[hotsList componentsJoinedByString:@","]]];
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.idcard!=nil){
        [res addObject:[self JSONItemFormat:@"\"idcard\":\"%@\"" data:self.idcard]];
    }
    if(self.img!=nil){
        [res addObject:[self JSONItemFormat:@"\"img\":\"%@\"" data:self.img]];
    }
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.is_check!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_check\":\"%@\"" data:self.is_check]];
    }
    if(self.is_member_favs!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_member_favs\":\"%@\"" data:self.is_member_favs]];
    }
    if(self.is_open!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_open\":\"%@\"" data:self.is_open]];
    }
    if(self.is_take!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_take\":\"%@\"" data:self.is_take]];
    }
    NSMutableArray *itemsList = [NSMutableArray new];
        for (ItemTable *item in self.items)
            [itemsList addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"items\":[%@]",[itemsList componentsJoinedByString:@","]]];
    if(self.last_dev!=nil){
        [res addObject:[self JSONItemFormat:@"\"last_dev\":\"%@\"" data:self.last_dev]];
    }
    if(self.last_ip!=nil){
        [res addObject:[self JSONItemFormat:@"\"last_ip\":\"%@\"" data:self.last_ip]];
    }
    if(self.last_lat!=nil){
        [res addObject:[self JSONItemFormat:@"\"last_lat\":\"%@\"" data:self.last_lat]];
    }
    if(self.last_lng!=nil){
        [res addObject:[self JSONItemFormat:@"\"last_lng\":\"%@\"" data:self.last_lng]];
    }
    if(self.last_sys!=nil){
        [res addObject:[self JSONItemFormat:@"\"last_sys\":\"%@\"" data:self.last_sys]];
    }
    if(self.last_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"last_time\":\"%@\"" data:self.last_time]];
    }
    if(self.likes!=nil){
        [res addObject:[self JSONItemFormat:@"\"likes\":\"%@\"" data:self.likes]];
    }
    NSMutableArray *member_imgList = [NSMutableArray new];
        for (Member_imgTable *item in self.member_img)
            [member_imgList addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"member_img\":[%@]",[member_imgList componentsJoinedByString:@","]]];
    if(self.min_price!=nil){
        [res addObject:[self JSONItemFormat:@"\"min_price\":\"%@\"" data:self.min_price]];
    }
    if(self.min_range!=nil){
        [res addObject:[self JSONItemFormat:@"\"min_range\":\"%@\"" data:self.min_range]];
    }
    if(self.money!=nil){
        [res addObject:[self JSONItemFormat:@"\"money\":\"%@\"" data:self.money]];
    }
    if(self.mosaic_card!=nil){
        [res addObject:[self JSONItemFormat:@"\"mosaic_card\":\"%@\"" data:self.mosaic_card]];
    }
    if(self.mosaic_health!=nil){
        [res addObject:[self JSONItemFormat:@"\"mosaic_health\":\"%@\"" data:self.mosaic_health]];
    }
    if(self.notice!=nil){
        [res addObject:[self JSONItemFormat:@"\"notice\":\"%@\"" data:self.notice]];
    }
    if(self.order_capability!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_capability\":\"%@\"" data:self.order_capability]];
    }
    if(self.orders!=nil){
        [res addObject:[self JSONItemFormat:@"\"orders\":\"%@\"" data:self.orders]];
    }
    if(self.sales!=nil){
        [res addObject:[self JSONItemFormat:@"\"sales\":\"%@\"" data:self.sales]];
    }
    if(self.password!=nil){
        [res addObject:[self JSONItemFormat:@"\"password\":\"%@\"" data:self.password]];
    }
    if(self.phone!=nil){
        [res addObject:[self JSONItemFormat:@"\"phone\":\"%@\"" data:self.phone]];
    }
    if(self.pos_lat!=nil){
        [res addObject:[self JSONItemFormat:@"\"pos_lat\":\"%@\"" data:self.pos_lat]];
    }
    if(self.pos_lng!=nil){
        [res addObject:[self JSONItemFormat:@"\"pos_lng\":\"%@\"" data:self.pos_lng]];
    }
    if(self.province!=nil){
        [res addObject:[self JSONItemFormat:@"\"province\":\"%@\"" data:self.province]];
    }
    if(self.province_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"province_id\":\"%@\"" data:self.province_id]];
    }
    if(self.reg_dev!=nil){
        [res addObject:[self JSONItemFormat:@"\"reg_dev\":\"%@\"" data:self.reg_dev]];
    }
    if(self.reg_ip!=nil){
        [res addObject:[self JSONItemFormat:@"\"reg_ip\":\"%@\"" data:self.reg_ip]];
    }
    if(self.reg_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"reg_time\":\"%@\"" data:self.reg_time]];
    }
    if(self.score!=nil){
        [res addObject:[self JSONItemFormat:@"\"score\":\"%@\"" data:self.score]];
    }
    if(self.service_capability!=nil){
        [res addObject:[self JSONItemFormat:@"\"service_capability\":\"%@\"" data:self.service_capability]];
    }
    if(self.sex!=nil){
        [res addObject:[self JSONItemFormat:@"\"sex\":\"%@\"" data:self.sex]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.statusStr!=nil){
        [res addObject:[self JSONItemFormat:@"\"statusStr\":\"%@\"" data:self.statusStr]];
    }
    if(self.stime!=nil){
        [res addObject:[self JSONItemFormat:@"\"stime\":\"%@\"" data:self.stime]];
    }
    if(self.tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"tele\":\"%@\"" data:self.tele]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    if(self.total!=nil){
        [res addObject:[self JSONItemFormat:@"\"total\":\"%@\"" data:self.total]];
    }
    if(self.town!=nil){
        [res addObject:[self JSONItemFormat:@"\"town\":\"%@\"" data:self.town]];
    }
    if(self.username!=nil){
        [res addObject:[self JSONItemFormat:@"\"username\":\"%@\"" data:self.username]];
    }
    if(self.weeks!=nil){
        [res addObject:[self JSONItemFormat:@"\"weeks\":\"%@\"" data:self.weeks]];
    }
    if(self.distance!=nil){
        [res addObject:[self JSONItemFormat:@"\"distance\":\"%@\"" data:self.distance]];
    }
    if(self.hometown!=nil){
        [res addObject:[self JSONItemFormat:@"\"hometown\":\"%@\"" data:self.hometown]];
    }
    if(self.statusTomorrow!=nil){
        [res addObject:[self JSONItemFormat:@"\"statusTomorrow\":\"%@\"" data:self.statusTomorrow]];
    }
    if(self.statusDistance!=nil){
        [res addObject:[self JSONItemFormat:@"\"statusDistance\":\"%@\"" data:self.statusDistance]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end
