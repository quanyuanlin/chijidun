/*
不要手动修改
*/
#import "Order_itemTable.h"

@implementation Order_itemTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.attr = [self stringFormat:JSON[@"attr"]];
    self.express_type = [self stringFormat:JSON[@"express_type"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.is_refund = [self stringFormat:JSON[@"is_refund"]];
    self.item_id = [self stringFormat:JSON[@"item_id"]];
    self.item_img = [self stringFormat:JSON[@"item_img"]];
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.mname = [self stringFormat:JSON[@"mname"]];
    self.num = [self stringFormat:JSON[@"num"]];
    self.order_id = [self stringFormat:JSON[@"order_id"]];
    self.orderid = [self stringFormat:JSON[@"orderid"]];
    self.price = [self stringFormat:JSON[@"price"]];
    self.remark = [self stringFormat:JSON[@"remark"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.title = [self stringFormat:JSON[@"title"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.attr!=nil){
        [res addObject:[self JSONItemFormat:@"\"attr\":\"%@\"" data:self.attr]];
    }
    if(self.express_type!=nil){
        [res addObject:[self JSONItemFormat:@"\"express_type\":\"%@\"" data:self.express_type]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.is_refund!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_refund\":\"%@\"" data:self.is_refund]];
    }
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    if(self.item_img!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_img\":\"%@\"" data:self.item_img]];
    }
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    if(self.mname!=nil){
        [res addObject:[self JSONItemFormat:@"\"mname\":\"%@\"" data:self.mname]];
    }
    if(self.num!=nil){
        [res addObject:[self JSONItemFormat:@"\"num\":\"%@\"" data:self.num]];
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
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    if(self.uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"uid\":\"%@\"" data:self.uid]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end