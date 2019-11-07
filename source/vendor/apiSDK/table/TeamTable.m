/*
不要手动修改
*/
#import "TeamTable.h"

@implementation TeamTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.address = [self stringFormat:JSON[@"address"]];
    self.area = [self stringFormat:JSON[@"area"]];
    self.city = [self stringFormat:JSON[@"city"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.invoice = [self stringFormat:JSON[@"invoice"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.names = [self stringFormat:JSON[@"names"]];
    self.nums = [self stringFormat:JSON[@"nums"]];
    self.price = [self stringFormat:JSON[@"price"]];
    self.province = [self stringFormat:JSON[@"province"]];
    self.remark = [self stringFormat:JSON[@"remark"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.team_name = [self stringFormat:JSON[@"team_name"]];
    self.tele = [self stringFormat:JSON[@"tele"]];
    self.times = [self stringFormat:JSON[@"times"]];
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
    if(self.address!=nil){
        [res addObject:[self JSONItemFormat:@"\"address\":\"%@\"" data:self.address]];
    }
    if(self.area!=nil){
        [res addObject:[self JSONItemFormat:@"\"area\":\"%@\"" data:self.area]];
    }
    if(self.city!=nil){
        [res addObject:[self JSONItemFormat:@"\"city\":\"%@\"" data:self.city]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.invoice!=nil){
        [res addObject:[self JSONItemFormat:@"\"invoice\":\"%@\"" data:self.invoice]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.names!=nil){
        [res addObject:[self JSONItemFormat:@"\"names\":\"%@\"" data:self.names]];
    }
    if(self.nums!=nil){
        [res addObject:[self JSONItemFormat:@"\"nums\":\"%@\"" data:self.nums]];
    }
    if(self.price!=nil){
        [res addObject:[self JSONItemFormat:@"\"price\":\"%@\"" data:self.price]];
    }
    if(self.province!=nil){
        [res addObject:[self JSONItemFormat:@"\"province\":\"%@\"" data:self.province]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.team_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"team_name\":\"%@\"" data:self.team_name]];
    }
    if(self.tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"tele\":\"%@\"" data:self.tele]];
    }
    if(self.times!=nil){
        [res addObject:[self JSONItemFormat:@"\"times\":\"%@\"" data:self.times]];
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