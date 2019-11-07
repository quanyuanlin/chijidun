/*
不要手动修改
*/
#import "MessageTable.h"

@implementation MessageTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.from_uid = [self stringFormat:JSON[@"from_uid"]];
    self.from_uname = [self stringFormat:JSON[@"from_uname"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.title = [self stringFormat:JSON[@"title"]];
    self.to_uid = [self stringFormat:JSON[@"to_uid"]];
    self.to_uname = [self stringFormat:JSON[@"to_uname"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.from_uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"from_uid\":\"%@\"" data:self.from_uid]];
    }
    if(self.from_uname!=nil){
        [res addObject:[self JSONItemFormat:@"\"from_uname\":\"%@\"" data:self.from_uname]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    if(self.to_uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"to_uid\":\"%@\"" data:self.to_uid]];
    }
    if(self.to_uname!=nil){
        [res addObject:[self JSONItemFormat:@"\"to_uname\":\"%@\"" data:self.to_uname]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end