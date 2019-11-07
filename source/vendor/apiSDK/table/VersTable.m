/*
不要手动修改
*/
#import "VersTable.h"

@implementation VersTable 

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
    self.name = [self stringFormat:JSON[@"name"]];
    self.remark = [self stringFormat:JSON[@"remark"]];
    self.url = [self stringFormat:JSON[@"url"]];
    self.vers = [self stringFormat:JSON[@"vers"]];
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
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    if(self.url!=nil){
        [res addObject:[self JSONItemFormat:@"\"url\":\"%@\"" data:self.url]];
    }
    if(self.vers!=nil){
        [res addObject:[self JSONItemFormat:@"\"vers\":\"%@\"" data:self.vers]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end