/*
不要手动修改
*/
#import "FeedbackTable.h"

@implementation FeedbackTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
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
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    if(self.uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"uid\":\"%@\"" data:self.uid]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end