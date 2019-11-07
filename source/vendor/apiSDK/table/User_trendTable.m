/*
不要手动修改
*/
#import "User_trendTable.h"

@implementation User_trendTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.data_content = [self stringFormat:JSON[@"data_content"]];
    self.data_id = [self stringFormat:JSON[@"data_id"]];
    self.data_type = [self stringFormat:JSON[@"data_type"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    self.uname = [self stringFormat:JSON[@"uname"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.data_content!=nil){
        [res addObject:[self JSONItemFormat:@"\"data_content\":\"%@\"" data:self.data_content]];
    }
    if(self.data_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"data_id\":\"%@\"" data:self.data_id]];
    }
    if(self.data_type!=nil){
        [res addObject:[self JSONItemFormat:@"\"data_type\":\"%@\"" data:self.data_type]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"uid\":\"%@\"" data:self.uid]];
    }
    if(self.uname!=nil){
        [res addObject:[self JSONItemFormat:@"\"uname\":\"%@\"" data:self.uname]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end