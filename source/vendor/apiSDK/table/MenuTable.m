/*
不要手动修改
*/
#import "MenuTable.h"

@implementation MenuTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.action_name = [self stringFormat:JSON[@"action_name"]];
    self.data = [self stringFormat:JSON[@"data"]];
    self.display = [self stringFormat:JSON[@"display"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.module_name = [self stringFormat:JSON[@"module_name"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.often = [self stringFormat:JSON[@"often"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.pid = [self stringFormat:JSON[@"pid"]];
    self.remark = [self stringFormat:JSON[@"remark"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.action_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"action_name\":\"%@\"" data:self.action_name]];
    }
    if(self.data!=nil){
        [res addObject:[self JSONItemFormat:@"\"data\":\"%@\"" data:self.data]];
    }
    if(self.display!=nil){
        [res addObject:[self JSONItemFormat:@"\"display\":\"%@\"" data:self.display]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.module_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"module_name\":\"%@\"" data:self.module_name]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.often!=nil){
        [res addObject:[self JSONItemFormat:@"\"often\":\"%@\"" data:self.often]];
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
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end