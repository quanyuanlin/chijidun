/*
不要手动修改
*/
#import "User_bindCallbackRequest.h"

@implementation User_bindCallbackRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.img = JSON[@"img"];
    self.keyid = JSON[@"keyid"];
    self.nickname = JSON[@"nickname"];
    self.type = JSON[@"type"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.img!=nil){
        [res addObject:[self JSONItemFormat:@"\"img\":\"%@\"" data:self.img]];
    }
    if(self.keyid!=nil){
        [res addObject:[self JSONItemFormat:@"\"keyid\":\"%@\"" data:self.keyid]];
    }
    if(self.nickname!=nil){
        [res addObject:[self JSONItemFormat:@"\"nickname\":\"%@\"" data:self.nickname]];
    }
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end