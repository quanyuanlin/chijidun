/*
不要手动修改
*/
#import "CashTable.h"

@implementation CashTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.admin_id = [self stringFormat:JSON[@"admin_id"]];
    self.admin_name = [self stringFormat:JSON[@"admin_name"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.item_id = [self stringFormat:JSON[@"item_id"]];
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.mname = [self stringFormat:JSON[@"mname"]];
    self.nums = [self stringFormat:JSON[@"nums"]];
    self.order_id = [self stringFormat:JSON[@"order_id"]];
    self.orderid = [self stringFormat:JSON[@"orderid"]];
    self.price = [self stringFormat:JSON[@"price"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.total = [self stringFormat:JSON[@"total"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.admin_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"admin_id\":\"%@\"" data:self.admin_id]];
    }
    if(self.admin_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"admin_name\":\"%@\"" data:self.admin_name]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    if(self.mname!=nil){
        [res addObject:[self JSONItemFormat:@"\"mname\":\"%@\"" data:self.mname]];
    }
    if(self.nums!=nil){
        [res addObject:[self JSONItemFormat:@"\"nums\":\"%@\"" data:self.nums]];
    }
    if(self.order_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_id\":\"%@\"" data:self.order_id]];
    }
    if(self.orderid!=nil){
        [res addObject:[self JSONItemFormat:@"\"orderid\":\"%@\"" data:self.orderid]];
    }
    if(self.price!=nil){
        [res addObject:[self JSONItemFormat:@"\"price\":\"%@\"" data:self.price]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.total!=nil){
        [res addObject:[self JSONItemFormat:@"\"total\":\"%@\"" data:self.total]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end