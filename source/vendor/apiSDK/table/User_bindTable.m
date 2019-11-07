/*
不要手动修改
*/
#import "User_bindTable.h"

@implementation User_bindTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.access_token = [self stringFormat:JSON[@"access_token"]];
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.keyid = [self stringFormat:JSON[@"keyid"]];
    self.refresh_token = [self stringFormat:JSON[@"refresh_token"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.type = [self stringFormat:JSON[@"type"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.access_token!=nil){
        [res addObject:[self JSONItemFormat:@"\"access_token\":\"%@\"" data:self.access_token]];
    }
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.keyid!=nil){
        [res addObject:[self JSONItemFormat:@"\"keyid\":\"%@\"" data:self.keyid]];
    }
    if(self.refresh_token!=nil){
        [res addObject:[self JSONItemFormat:@"\"refresh_token\":\"%@\"" data:self.refresh_token]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    if(self.uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"uid\":\"%@\"" data:self.uid]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end