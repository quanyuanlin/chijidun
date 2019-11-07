/*
不要手动修改
*/
#import "Order_refundTable.h"

@implementation Order_refundTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.account = [self stringFormat:JSON[@"account"]];
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.admin_id = [self stringFormat:JSON[@"admin_id"]];
    self.admin_name = [self stringFormat:JSON[@"admin_name"]];
    self.alipay_name = [self stringFormat:JSON[@"alipay_name"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.order_id = [self stringFormat:JSON[@"order_id"]];
    self.order_price = [self stringFormat:JSON[@"order_price"]];
    self.orderid = [self stringFormat:JSON[@"orderid"]];
    self.remark = [self stringFormat:JSON[@"remark"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.type = [self stringFormat:JSON[@"type"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    self.uname = [self stringFormat:JSON[@"uname"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.account!=nil){
        [res addObject:[self JSONItemFormat:@"\"account\":\"%@\"" data:self.account]];
    }
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.admin_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"admin_id\":\"%@\"" data:self.admin_id]];
    }
    if(self.admin_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"admin_name\":\"%@\"" data:self.admin_name]];
    }
    if(self.alipay_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"alipay_name\":\"%@\"" data:self.alipay_name]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.order_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_id\":\"%@\"" data:self.order_id]];
    }
    if(self.order_price!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_price\":\"%@\"" data:self.order_price]];
    }
    if(self.orderid!=nil){
        [res addObject:[self JSONItemFormat:@"\"orderid\":\"%@\"" data:self.orderid]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
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