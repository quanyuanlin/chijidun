/*
不要手动修改
*/
#import "Custom_orderTable.h"

@implementation Custom_orderTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.address = [self stringFormat:JSON[@"address"]];
    self.fruit = [self stringFormat:JSON[@"fruit"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.item_id = [self stringFormat:JSON[@"item_id"]];
    self.meat = [self stringFormat:JSON[@"meat"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.nums = [self stringFormat:JSON[@"nums"]];
    self.pays = [self stringFormat:JSON[@"pays"]];
    self.pays_data = [self stringFormat:JSON[@"pays_data"]];
    self.pays_price = [self stringFormat:JSON[@"pays_price"]];
    self.pays_sn = [self stringFormat:JSON[@"pays_sn"]];
    self.pays_status = [self stringFormat:JSON[@"pays_status"]];
    self.pays_time = [self stringFormat:JSON[@"pays_time"]];
    self.price = [self stringFormat:JSON[@"price"]];
    self.remark = [self stringFormat:JSON[@"remark"]];
    self.soup = [self stringFormat:JSON[@"soup"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.tele = [self stringFormat:JSON[@"tele"]];
    self.times = [self stringFormat:JSON[@"times"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    self.uname = [self stringFormat:JSON[@"uname"]];
    self.vege = [self stringFormat:JSON[@"vege"]];
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
    if(self.fruit!=nil){
        [res addObject:[self JSONItemFormat:@"\"fruit\":\"%@\"" data:self.fruit]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    if(self.meat!=nil){
        [res addObject:[self JSONItemFormat:@"\"meat\":\"%@\"" data:self.meat]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.nums!=nil){
        [res addObject:[self JSONItemFormat:@"\"nums\":\"%@\"" data:self.nums]];
    }
    if(self.pays!=nil){
        [res addObject:[self JSONItemFormat:@"\"pays\":\"%@\"" data:self.pays]];
    }
    if(self.pays_data!=nil){
        [res addObject:[self JSONItemFormat:@"\"pays_data\":\"%@\"" data:self.pays_data]];
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
    if(self.price!=nil){
        [res addObject:[self JSONItemFormat:@"\"price\":\"%@\"" data:self.price]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    if(self.soup!=nil){
        [res addObject:[self JSONItemFormat:@"\"soup\":\"%@\"" data:self.soup]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"tele\":\"%@\"" data:self.tele]];
    }
    if(self.times!=nil){
        [res addObject:[self JSONItemFormat:@"\"times\":\"%@\"" data:self.times]];
    }
    if(self.uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"uid\":\"%@\"" data:self.uid]];
    }
    if(self.uname!=nil){
        [res addObject:[self JSONItemFormat:@"\"uname\":\"%@\"" data:self.uname]];
    }
    if(self.vege!=nil){
        [res addObject:[self JSONItemFormat:@"\"vege\":\"%@\"" data:self.vege]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end