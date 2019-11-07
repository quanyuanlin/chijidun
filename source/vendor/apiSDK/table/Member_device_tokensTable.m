/*
不要手动修改
*/
#import "Member_device_tokensTable.h"

@implementation Member_device_tokensTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.Id = [self stringFormat:JSON[@"id"]];
    self.last_time = [self stringFormat:JSON[@"last_time"]];
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.platform = [self stringFormat:JSON[@"platform"]];
    self.token = [self stringFormat:JSON[@"token"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.last_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"last_time\":\"%@\"" data:self.last_time]];
    }
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    if(self.platform!=nil){
        [res addObject:[self JSONItemFormat:@"\"platform\":\"%@\"" data:self.platform]];
    }
    if(self.token!=nil){
        [res addObject:[self JSONItemFormat:@"\"token\":\"%@\"" data:self.token]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end