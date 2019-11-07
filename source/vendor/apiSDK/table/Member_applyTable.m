/*
不要手动修改
*/
#import "Member_applyTable.h"

@implementation Member_applyTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.tele = [self stringFormat:JSON[@"tele"]];
    self.username = [self stringFormat:JSON[@"username"]];
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
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"tele\":\"%@\"" data:self.tele]];
    }
    if(self.username!=nil){
        [res addObject:[self JSONItemFormat:@"\"username\":\"%@\"" data:self.username]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end