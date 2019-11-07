/*
不要手动修改
*/
#import "MessageAddRequest.h"

@implementation MessageAddRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.from_uid = JSON[@"from_uid"];
    self.info = JSON[@"info"];
    self.title = JSON[@"title"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.from_uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"from_uid\":\"%@\"" data:self.from_uid]];
    }
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end