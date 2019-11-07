/*
不要手动修改
*/
#import "UserTable.h"

@implementation UserTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.address = [self stringFormat:JSON[@"address"]];
    self.area = [self stringFormat:JSON[@"area"]];
    self.area_id = [self stringFormat:JSON[@"area_id"]];
    self.birthday = [self stringFormat:JSON[@"birthday"]];
    self.city = [self stringFormat:JSON[@"city"]];
    self.city_id = [self stringFormat:JSON[@"city_id"]];
    self.company_id = [self stringFormat:JSON[@"company_id"]];
    self.cover = [self stringFormat:JSON[@"cover"]];
    self.deviceid = [self stringFormat:JSON[@"deviceid"]];
    self.email = [self stringFormat:JSON[@"email"]];
    self.favs = [self stringFormat:JSON[@"favs"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.intro = [self stringFormat:JSON[@"intro"]];
    self.is_qq_bind = [self stringFormat:JSON[@"is_qq_bind"]];
    self.is_vip = [self stringFormat:JSON[@"is_vip"]];
    self.is_weibo_bind = [self stringFormat:JSON[@"is_weibo_bind"]];
    self.is_weixin_bind = [self stringFormat:JSON[@"is_weixin_bind"]];
    self.last_dev = [self stringFormat:JSON[@"last_dev"]];
    self.last_ip = [self stringFormat:JSON[@"last_ip"]];
    self.last_lat = [self stringFormat:JSON[@"last_lat"]];
    self.last_lng = [self stringFormat:JSON[@"last_lng"]];
    self.last_sys = [self stringFormat:JSON[@"last_sys"]];
    self.last_time = [self stringFormat:JSON[@"last_time"]];
    self.level = [self stringFormat:JSON[@"level"]];
    self.likes = [self stringFormat:JSON[@"likes"]];
    self.member_reply_uncheck_count = [self stringFormat:JSON[@"member_reply_uncheck_count"]];
    self.msg_express = [self stringFormat:JSON[@"msg_express"]];
    self.msg_sales = [self stringFormat:JSON[@"msg_sales"]];
    self.msg_sys = [self stringFormat:JSON[@"msg_sys"]];
    self.openid = [self stringFormat:JSON[@"openid"]];
    self.orders = [self stringFormat:JSON[@"orders"]];
    self.password = [self stringFormat:JSON[@"password"]];
    self.province = [self stringFormat:JSON[@"province"]];
    self.province_id = [self stringFormat:JSON[@"province_id"]];
    self.quans = [self stringFormat:JSON[@"quans"]];
    self.reg_dev = [self stringFormat:JSON[@"reg_dev"]];
    self.reg_ip = [self stringFormat:JSON[@"reg_ip"]];
    self.reg_time = [self stringFormat:JSON[@"reg_time"]];
    self.score = [self stringFormat:JSON[@"score"]];
    self.sex = [self stringFormat:JSON[@"sex"]];
    self.sign = [self stringFormat:JSON[@"sign"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.tele = [self stringFormat:JSON[@"tele"]];
    self.url = [self stringFormat:JSON[@"url"]];
    self.username = [self stringFormat:JSON[@"username"]];
    self.weibo = [self stringFormat:JSON[@"weibo"]];
    self.weixin = [self stringFormat:JSON[@"weixin"]];
    self.token = [self stringFormat:JSON[@"token"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.address!=nil){
        [res addObject:[self JSONItemFormat:@"\"address\":\"%@\"" data:self.address]];
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
    if(self.city!=nil){
        [res addObject:[self JSONItemFormat:@"\"city\":\"%@\"" data:self.city]];
    }
    if(self.city_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"city_id\":\"%@\"" data:self.city_id]];
    }
    if(self.company_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"company_id\":\"%@\"" data:self.company_id]];
    }
    if(self.cover!=nil){
        [res addObject:[self JSONItemFormat:@"\"cover\":\"%@\"" data:self.cover]];
    }
    if(self.deviceid!=nil){
        [res addObject:[self JSONItemFormat:@"\"deviceid\":\"%@\"" data:self.deviceid]];
    }
    if(self.email!=nil){
        [res addObject:[self JSONItemFormat:@"\"email\":\"%@\"" data:self.email]];
    }
    if(self.favs!=nil){
        [res addObject:[self JSONItemFormat:@"\"favs\":\"%@\"" data:self.favs]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.img!=nil){
        [res addObject:[self JSONItemFormat:@"\"img\":\"%@\"" data:self.img]];
    }
    if(self.intro!=nil){
        [res addObject:[self JSONItemFormat:@"\"intro\":\"%@\"" data:self.intro]];
    }
    if(self.is_qq_bind!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_qq_bind\":\"%@\"" data:self.is_qq_bind]];
    }
    if(self.is_vip!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_vip\":\"%@\"" data:self.is_vip]];
    }
    if(self.is_weibo_bind!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_weibo_bind\":\"%@\"" data:self.is_weibo_bind]];
    }
    if(self.is_weixin_bind!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_weixin_bind\":\"%@\"" data:self.is_weixin_bind]];
    }
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
    if(self.level!=nil){
        [res addObject:[self JSONItemFormat:@"\"level\":\"%@\"" data:self.level]];
    }
    if(self.likes!=nil){
        [res addObject:[self JSONItemFormat:@"\"likes\":\"%@\"" data:self.likes]];
    }
    if(self.member_reply_uncheck_count!=nil){
        [res addObject:[self JSONItemFormat:@"\"member_reply_uncheck_count\":\"%@\"" data:self.member_reply_uncheck_count]];
    }
    if(self.msg_express!=nil){
        [res addObject:[self JSONItemFormat:@"\"msg_express\":\"%@\"" data:self.msg_express]];
    }
    if(self.msg_sales!=nil){
        [res addObject:[self JSONItemFormat:@"\"msg_sales\":\"%@\"" data:self.msg_sales]];
    }
    if(self.msg_sys!=nil){
        [res addObject:[self JSONItemFormat:@"\"msg_sys\":\"%@\"" data:self.msg_sys]];
    }
    if(self.openid!=nil){
        [res addObject:[self JSONItemFormat:@"\"openid\":\"%@\"" data:self.openid]];
    }
    if(self.orders!=nil){
        [res addObject:[self JSONItemFormat:@"\"orders\":\"%@\"" data:self.orders]];
    }
    if(self.password!=nil){
        [res addObject:[self JSONItemFormat:@"\"password\":\"%@\"" data:self.password]];
    }
    if(self.province!=nil){
        [res addObject:[self JSONItemFormat:@"\"province\":\"%@\"" data:self.province]];
    }
    if(self.province_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"province_id\":\"%@\"" data:self.province_id]];
    }
    if(self.quans!=nil){
        [res addObject:[self JSONItemFormat:@"\"quans\":\"%@\"" data:self.quans]];
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
    if(self.sex!=nil){
        [res addObject:[self JSONItemFormat:@"\"sex\":\"%@\"" data:self.sex]];
    }
    if(self.sign!=nil){
        [res addObject:[self JSONItemFormat:@"\"sign\":\"%@\"" data:self.sign]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"tele\":\"%@\"" data:self.tele]];
    }
    if(self.url!=nil){
        [res addObject:[self JSONItemFormat:@"\"url\":\"%@\"" data:self.url]];
    }
    if(self.username!=nil){
        [res addObject:[self JSONItemFormat:@"\"username\":\"%@\"" data:self.username]];
    }
    if(self.weibo!=nil){
        [res addObject:[self JSONItemFormat:@"\"weibo\":\"%@\"" data:self.weibo]];
    }
    if(self.weixin!=nil){
        [res addObject:[self JSONItemFormat:@"\"weixin\":\"%@\"" data:self.weixin]];
    }
    if(self.token!=nil){
        [res addObject:[self JSONItemFormat:@"\"token\":\"%@\"" data:self.token]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end