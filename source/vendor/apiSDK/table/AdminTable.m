/*
不要手动修改
*/
#import "AdminTable.h"

@implementation AdminTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.email = [self stringFormat:JSON[@"email"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.last_ip = [self stringFormat:JSON[@"last_ip"]];
    self.last_time = [self stringFormat:JSON[@"last_time"]];
    self.password = [self stringFormat:JSON[@"password"]];
    self.role_id = [self stringFormat:JSON[@"role_id"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.username = [self stringFormat:JSON[@"username"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.email!=nil){
        [res addObject:[self JSONItemFormat:@"\"email\":\"%@\"" data:self.email]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.last_ip!=nil){
        [res addObject:[self JSONItemFormat:@"\"last_ip\":\"%@\"" data:self.last_ip]];
    }
    if(self.last_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"last_time\":\"%@\"" data:self.last_time]];
    }
    if(self.password!=nil){
        [res addObject:[self JSONItemFormat:@"\"password\":\"%@\"" data:self.password]];
    }
    if(self.role_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"role_id\":\"%@\"" data:self.role_id]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.username!=nil){
        [res addObject:[self JSONItemFormat:@"\"username\":\"%@\"" data:self.username]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end