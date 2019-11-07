/*
不要手动修改
*/
#import "Tuan_order_itemTable.h"

@implementation Tuan_order_itemTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.date = [self stringFormat:JSON[@"date"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.item_ids = [self stringFormat:JSON[@"item_ids"]];
    self.item_num = [self stringFormat:JSON[@"item_num"]];
    self.item_price = [self stringFormat:JSON[@"item_price"]];
    self.item_title = [self stringFormat:JSON[@"item_title"]];
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.mname = [self stringFormat:JSON[@"mname"]];
    self.nums = [self stringFormat:JSON[@"nums"]];
    self.order_id = [self stringFormat:JSON[@"order_id"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.tuan_id = [self stringFormat:JSON[@"tuan_id"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.date!=nil){
        [res addObject:[self JSONItemFormat:@"\"date\":\"%@\"" data:self.date]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.item_ids!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_ids\":\"%@\"" data:self.item_ids]];
    }
    if(self.item_num!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_num\":\"%@\"" data:self.item_num]];
    }
    if(self.item_price!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_price\":\"%@\"" data:self.item_price]];
    }
    if(self.item_title!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_title\":\"%@\"" data:self.item_title]];
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
    if(self.ordid!=nil){
        [res addObject:[self JSONItemFormat:@"\"ordid\":\"%@\"" data:self.ordid]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.tuan_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"tuan_id\":\"%@\"" data:self.tuan_id]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end