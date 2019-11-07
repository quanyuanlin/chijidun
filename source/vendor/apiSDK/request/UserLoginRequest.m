/*
不要手动修改
*/
#import "UserLoginRequest.h"

@implementation UserLoginRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.password = JSON[@"password"];
    self.tele = JSON[@"tele"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.password!=nil){
        [res addObject:[self JSONItemFormat:@"\"password\":\"%@\"" data:self.password]];
    }
    if(self.tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"tele\":\"%@\"" data:self.tele]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end