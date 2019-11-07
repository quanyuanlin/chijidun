/*
不要手动修改
*/
#import "Message_tplTable.h"

@implementation Message_tplTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.alias = [self stringFormat:JSON[@"alias"]];
    self.content = [self stringFormat:JSON[@"content"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.is_sys = [self stringFormat:JSON[@"is_sys"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.type = [self stringFormat:JSON[@"type"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.alias!=nil){
        [res addObject:[self JSONItemFormat:@"\"alias\":\"%@\"" data:self.alias]];
    }
    if(self.content!=nil){
        [res addObject:[self JSONItemFormat:@"\"content\":\"%@\"" data:self.content]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.is_sys!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_sys\":\"%@\"" data:self.is_sys]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end