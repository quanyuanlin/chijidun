/*
不要手动修改
*/
#import "CityTable.h"

@implementation CityTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.pid = [self stringFormat:JSON[@"pid"]];
    self.remark = [self stringFormat:JSON[@"remark"]];
    self.spid = [self stringFormat:JSON[@"spid"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.update_time = [self stringFormat:JSON[@"update_time"]];
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
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.ordid!=nil){
        [res addObject:[self JSONItemFormat:@"\"ordid\":\"%@\"" data:self.ordid]];
    }
    if(self.pid!=nil){
        [res addObject:[self JSONItemFormat:@"\"pid\":\"%@\"" data:self.pid]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    if(self.spid!=nil){
        [res addObject:[self JSONItemFormat:@"\"spid\":\"%@\"" data:self.spid]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.update_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"update_time\":\"%@\"" data:self.update_time]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end