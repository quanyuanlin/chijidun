/*
不要手动修改
*/
#import "OrderPayRequest.h"

@implementation OrderPayRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.Id = JSON[@"id"];
    self.pays = JSON[@"pays"];
    self.pays_id = JSON[@"pays_id"];
    self.platform = JSON[@"platform"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.pays!=nil){
        [res addObject:[self JSONItemFormat:@"\"pays\":\"%@\"" data:self.pays]];
    }
    if(self.pays_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"pays_id\":\"%@\"" data:self.pays_id]];
    }
    if(self.platform!=nil){
        [res addObject:[self JSONItemFormat:@"\"platform\":\"%@\"" data:self.platform]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end