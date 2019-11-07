/*
不要手动修改
*/
#import "Meet_orderTable.h"

@implementation Meet_orderTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.addr_address = [self stringFormat:JSON[@"addr_address"]];
    self.addr_area = [self stringFormat:JSON[@"addr_area"]];
    self.addr_city = [self stringFormat:JSON[@"addr_city"]];
    self.addr_name = [self stringFormat:JSON[@"addr_name"]];
    self.addr_province = [self stringFormat:JSON[@"addr_province"]];
    self.addr_tele = [self stringFormat:JSON[@"addr_tele"]];
    self.addr_zipcode = [self stringFormat:JSON[@"addr_zipcode"]];
    self.check_time = [self stringFormat:JSON[@"check_time"]];
    self.check_uid = [self stringFormat:JSON[@"check_uid"]];
    self.days = [self stringFormat:JSON[@"days"]];
    self.express = [self stringFormat:JSON[@"express"]];
    self.express_info = [self stringFormat:JSON[@"express_info"]];
    self.express_name = [self stringFormat:JSON[@"express_name"]];
    self.express_remark = [self stringFormat:JSON[@"express_remark"]];
    self.express_sn = [self stringFormat:JSON[@"express_sn"]];
    self.express_tele = [self stringFormat:JSON[@"express_tele"]];
    self.express_time = [self stringFormat:JSON[@"express_time"]];
    self.express_type = [self stringFormat:JSON[@"express_type"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.invoice = [self stringFormat:JSON[@"invoice"]];
    self.meet_id = [self stringFormat:JSON[@"meet_id"]];
    self.meet_price = [self stringFormat:JSON[@"meet_price"]];
    self.nums = [self stringFormat:JSON[@"nums"]];
    self.orderid = [self stringFormat:JSON[@"orderid"]];
    self.pays = [self stringFormat:JSON[@"pays"]];
    self.pays_data = [self stringFormat:JSON[@"pays_data"]];
    self.pays_id = [self stringFormat:JSON[@"pays_id"]];
    self.pays_price = [self stringFormat:JSON[@"pays_price"]];
    self.pays_sn = [self stringFormat:JSON[@"pays_sn"]];
    self.pays_status = [self stringFormat:JSON[@"pays_status"]];
    self.pays_time = [self stringFormat:JSON[@"pays_time"]];
    self.remark = [self stringFormat:JSON[@"remark"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.times = [self stringFormat:JSON[@"times"]];
    self.total = [self stringFormat:JSON[@"total"]];
    self.type = [self stringFormat:JSON[@"type"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    self.uname = [self stringFormat:JSON[@"uname"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.addr_address!=nil){
        [res addObject:[self JSONItemFormat:@"\"addr_address\":\"%@\"" data:self.addr_address]];
    }
    if(self.addr_area!=nil){
        [res addObject:[self JSONItemFormat:@"\"addr_area\":\"%@\"" data:self.addr_area]];
    }
    if(self.addr_city!=nil){
        [res addObject:[self JSONItemFormat:@"\"addr_city\":\"%@\"" data:self.addr_city]];
    }
    if(self.addr_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"addr_name\":\"%@\"" data:self.addr_name]];
    }
    if(self.addr_province!=nil){
        [res addObject:[self JSONItemFormat:@"\"addr_province\":\"%@\"" data:self.addr_province]];
    }
    if(self.addr_tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"addr_tele\":\"%@\"" data:self.addr_tele]];
    }
    if(self.addr_zipcode!=nil){
        [res addObject:[self JSONItemFormat:@"\"addr_zipcode\":\"%@\"" data:self.addr_zipcode]];
    }
    if(self.check_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"check_time\":\"%@\"" data:self.check_time]];
    }
    if(self.check_uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"check_uid\":\"%@\"" data:self.check_uid]];
    }
    if(self.days!=nil){
        [res addObject:[self JSONItemFormat:@"\"days\":\"%@\"" data:self.days]];
    }
    if(self.express!=nil){
        [res addObject:[self JSONItemFormat:@"\"express\":\"%@\"" data:self.express]];
    }
    if(self.express_info!=nil){
        [res addObject:[self JSONItemFormat:@"\"express_info\":\"%@\"" data:self.express_info]];
    }
    if(self.express_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"express_name\":\"%@\"" data:self.express_name]];
    }
    if(self.express_remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"express_remark\":\"%@\"" data:self.express_remark]];
    }
    if(self.express_sn!=nil){
        [res addObject:[self JSONItemFormat:@"\"express_sn\":\"%@\"" data:self.express_sn]];
    }
    if(self.express_tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"express_tele\":\"%@\"" data:self.express_tele]];
    }
    if(self.express_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"express_time\":\"%@\"" data:self.express_time]];
    }
    if(self.express_type!=nil){
        [res addObject:[self JSONItemFormat:@"\"express_type\":\"%@\"" data:self.express_type]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.invoice!=nil){
        [res addObject:[self JSONItemFormat:@"\"invoice\":\"%@\"" data:self.invoice]];
    }
    if(self.meet_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"meet_id\":\"%@\"" data:self.meet_id]];
    }
    if(self.meet_price!=nil){
        [res addObject:[self JSONItemFormat:@"\"meet_price\":\"%@\"" data:self.meet_price]];
    }
    if(self.nums!=nil){
        [res addObject:[self JSONItemFormat:@"\"nums\":\"%@\"" data:self.nums]];
    }
    if(self.orderid!=nil){
        [res addObject:[self JSONItemFormat:@"\"orderid\":\"%@\"" data:self.orderid]];
    }
    if(self.pays!=nil){
        [res addObject:[self JSONItemFormat:@"\"pays\":\"%@\"" data:self.pays]];
    }
    if(self.pays_data!=nil){
        [res addObject:[self JSONItemFormat:@"\"pays_data\":\"%@\"" data:self.pays_data]];
    }
    if(self.pays_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"pays_id\":\"%@\"" data:self.pays_id]];
    }
    if(self.pays_price!=nil){
        [res addObject:[self JSONItemFormat:@"\"pays_price\":\"%@\"" data:self.pays_price]];
    }
    if(self.pays_sn!=nil){
        [res addObject:[self JSONItemFormat:@"\"pays_sn\":\"%@\"" data:self.pays_sn]];
    }
    if(self.pays_status!=nil){
        [res addObject:[self JSONItemFormat:@"\"pays_status\":\"%@\"" data:self.pays_status]];
    }
    if(self.pays_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"pays_time\":\"%@\"" data:self.pays_time]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.times!=nil){
        [res addObject:[self JSONItemFormat:@"\"times\":\"%@\"" data:self.times]];
    }
    if(self.total!=nil){
        [res addObject:[self JSONItemFormat:@"\"total\":\"%@\"" data:self.total]];
    }
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    if(self.uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"uid\":\"%@\"" data:self.uid]];
    }
    if(self.uname!=nil){
        [res addObject:[self JSONItemFormat:@"\"uname\":\"%@\"" data:self.uname]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end