/*
不要手动修改
*/
#import "Express_logsTable.h"

@implementation Express_logsTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.express_list = [self stringFormat:JSON[@"express_list"]];
    self.express_name = [self stringFormat:JSON[@"express_name"]];
    self.express_sn = [self stringFormat:JSON[@"express_sn"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.express_list!=nil){
        [res addObject:[self JSONItemFormat:@"\"express_list\":\"%@\"" data:self.express_list]];
    }
    if(self.express_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"express_name\":\"%@\"" data:self.express_name]];
    }
    if(self.express_sn!=nil){
        [res addObject:[self JSONItemFormat:@"\"express_sn\":\"%@\"" data:self.express_sn]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end