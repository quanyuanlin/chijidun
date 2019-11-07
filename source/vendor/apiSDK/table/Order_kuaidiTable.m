/*
不要手动修改
*/
#import "Order_kuaidiTable.h"

@implementation Order_kuaidiTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.kuaidi_add = [self stringFormat:JSON[@"kuaidi_add"]];
    self.kuaidi_name = [self stringFormat:JSON[@"kuaidi_name"]];
    self.kuaidi_price = [self stringFormat:JSON[@"kuaidi_price"]];
    self.kuaidi_remark = [self stringFormat:JSON[@"kuaidi_remark"]];
    self.kuaidi_sn = [self stringFormat:JSON[@"kuaidi_sn"]];
    self.kuaidi_status = [self stringFormat:JSON[@"kuaidi_status"]];
    self.kuaidi_tele = [self stringFormat:JSON[@"kuaidi_tele"]];
    self.m_address = [self stringFormat:JSON[@"m_address"]];
    self.m_id = [self stringFormat:JSON[@"m_id"]];
    self.m_name = [self stringFormat:JSON[@"m_name"]];
    self.m_tele = [self stringFormat:JSON[@"m_tele"]];
    self.order_id = [self stringFormat:JSON[@"order_id"]];
    self.order_orderid = [self stringFormat:JSON[@"order_orderid"]];
    self.order_prices = [self stringFormat:JSON[@"order_prices"]];
    self.order_times = [self stringFormat:JSON[@"order_times"]];
    self.time_qiwang = [self stringFormat:JSON[@"time_qiwang"]];
    self.time_shiji = [self stringFormat:JSON[@"time_shiji"]];
    self.time_wancheng = [self stringFormat:JSON[@"time_wancheng"]];
    self.u_address = [self stringFormat:JSON[@"u_address"]];
    self.u_name = [self stringFormat:JSON[@"u_name"]];
    self.u_tele = [self stringFormat:JSON[@"u_tele"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.kuaidi_add!=nil){
        [res addObject:[self JSONItemFormat:@"\"kuaidi_add\":\"%@\"" data:self.kuaidi_add]];
    }
    if(self.kuaidi_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"kuaidi_name\":\"%@\"" data:self.kuaidi_name]];
    }
    if(self.kuaidi_price!=nil){
        [res addObject:[self JSONItemFormat:@"\"kuaidi_price\":\"%@\"" data:self.kuaidi_price]];
    }
    if(self.kuaidi_remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"kuaidi_remark\":\"%@\"" data:self.kuaidi_remark]];
    }
    if(self.kuaidi_sn!=nil){
        [res addObject:[self JSONItemFormat:@"\"kuaidi_sn\":\"%@\"" data:self.kuaidi_sn]];
    }
    if(self.kuaidi_status!=nil){
        [res addObject:[self JSONItemFormat:@"\"kuaidi_status\":\"%@\"" data:self.kuaidi_status]];
    }
    if(self.kuaidi_tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"kuaidi_tele\":\"%@\"" data:self.kuaidi_tele]];
    }
    if(self.m_address!=nil){
        [res addObject:[self JSONItemFormat:@"\"m_address\":\"%@\"" data:self.m_address]];
    }
    if(self.m_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"m_id\":\"%@\"" data:self.m_id]];
    }
    if(self.m_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"m_name\":\"%@\"" data:self.m_name]];
    }
    if(self.m_tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"m_tele\":\"%@\"" data:self.m_tele]];
    }
    if(self.order_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_id\":\"%@\"" data:self.order_id]];
    }
    if(self.order_orderid!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_orderid\":\"%@\"" data:self.order_orderid]];
    }
    if(self.order_prices!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_prices\":\"%@\"" data:self.order_prices]];
    }
    if(self.order_times!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_times\":\"%@\"" data:self.order_times]];
    }
    if(self.time_qiwang!=nil){
        [res addObject:[self JSONItemFormat:@"\"time_qiwang\":\"%@\"" data:self.time_qiwang]];
    }
    if(self.time_shiji!=nil){
        [res addObject:[self JSONItemFormat:@"\"time_shiji\":\"%@\"" data:self.time_shiji]];
    }
    if(self.time_wancheng!=nil){
        [res addObject:[self JSONItemFormat:@"\"time_wancheng\":\"%@\"" data:self.time_wancheng]];
    }
    if(self.u_address!=nil){
        [res addObject:[self JSONItemFormat:@"\"u_address\":\"%@\"" data:self.u_address]];
    }
    if(self.u_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"u_name\":\"%@\"" data:self.u_name]];
    }
    if(self.u_tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"u_tele\":\"%@\"" data:self.u_tele]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end