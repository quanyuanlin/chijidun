/*
不要手动修改
*/
#import "UserScore_listResponse.h"

@implementation UserScore_listResponse 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.data =[[UserScore_listData new]fromJSON:JSON[@"data"]];
    self.result = [self stringFormat:JSON[@"result"]];
    self.status = [self stringFormat:JSON[@"status"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.data!=nil){
        [res addObject:[NSString stringWithFormat:@"\"data\":%@",[self.data toJSON]]];
    }
    if(self.result!=nil){
        [res addObject:[self JSONItemFormat:@"\"result\":\"%@\"" data:self.result]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end