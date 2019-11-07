/*
不要手动修改
*/
#import "SessionTable.h"

@implementation SessionTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.Id = [self stringFormat:JSON[@"id"]];
    self.session_data = [self stringFormat:JSON[@"session_data"]];
    self.session_expire = [self stringFormat:JSON[@"session_expire"]];
    self.session_id = [self stringFormat:JSON[@"session_id"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.session_data!=nil){
        [res addObject:[self JSONItemFormat:@"\"session_data\":\"%@\"" data:self.session_data]];
    }
    if(self.session_expire!=nil){
        [res addObject:[self JSONItemFormat:@"\"session_expire\":\"%@\"" data:self.session_expire]];
    }
    if(self.session_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"session_id\":\"%@\"" data:self.session_id]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end