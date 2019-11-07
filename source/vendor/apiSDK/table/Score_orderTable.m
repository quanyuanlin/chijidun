/*
不要手动修改
*/
#import "Score_orderTable.h"

@implementation Score_orderTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.address = [self stringFormat:JSON[@"address"]];
    self.consignee = [self stringFormat:JSON[@"consignee"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.item_id = [self stringFormat:JSON[@"item_id"]];
    self.item_name = [self stringFormat:JSON[@"item_name"]];
    self.item_num = [self stringFormat:JSON[@"item_num"]];
    self.mobile = [self stringFormat:JSON[@"mobile"]];
    self.order_score = [self stringFormat:JSON[@"order_score"]];
    self.order_sn = [self stringFormat:JSON[@"order_sn"]];
    self.remark = [self stringFormat:JSON[@"remark"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    self.uname = [self stringFormat:JSON[@"uname"]];
    self.zip = [self stringFormat:JSON[@"zip"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.address!=nil){
        [res addObject:[self JSONItemFormat:@"\"address\":\"%@\"" data:self.address]];
    }
    if(self.consignee!=nil){
        [res addObject:[self JSONItemFormat:@"\"consignee\":\"%@\"" data:self.consignee]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    if(self.item_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_name\":\"%@\"" data:self.item_name]];
    }
    if(self.item_num!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_num\":\"%@\"" data:self.item_num]];
    }
    if(self.mobile!=nil){
        [res addObject:[self JSONItemFormat:@"\"mobile\":\"%@\"" data:self.mobile]];
    }
    if(self.order_score!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_score\":\"%@\"" data:self.order_score]];
    }
    if(self.order_sn!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_sn\":\"%@\"" data:self.order_sn]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"uid\":\"%@\"" data:self.uid]];
    }
    if(self.uname!=nil){
        [res addObject:[self JSONItemFormat:@"\"uname\":\"%@\"" data:self.uname]];
    }
    if(self.zip!=nil){
        [res addObject:[self JSONItemFormat:@"\"zip\":\"%@\"" data:self.zip]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end