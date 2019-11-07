/*
不要手动修改
*/
#import "Admin_logTable.h"

@implementation Admin_logTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.actions = [self stringFormat:JSON[@"actions"]];
    self.admin_id = [self stringFormat:JSON[@"admin_id"]];
    self.admin_name = [self stringFormat:JSON[@"admin_name"]];
    self.admin_time = [self stringFormat:JSON[@"admin_time"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.ip = [self stringFormat:JSON[@"ip"]];
    self.remark = [self stringFormat:JSON[@"remark"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.actions!=nil){
        [res addObject:[self JSONItemFormat:@"\"actions\":\"%@\"" data:self.actions]];
    }
    if(self.admin_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"admin_id\":\"%@\"" data:self.admin_id]];
    }
    if(self.admin_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"admin_name\":\"%@\"" data:self.admin_name]];
    }
    if(self.admin_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"admin_time\":\"%@\"" data:self.admin_time]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.ip!=nil){
        [res addObject:[self JSONItemFormat:@"\"ip\":\"%@\"" data:self.ip]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end