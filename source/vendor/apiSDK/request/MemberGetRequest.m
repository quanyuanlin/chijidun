/*
不要手动修改
*/
#import "MemberGetRequest.h"

@implementation MemberGetRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.days = JSON[@"days"];
    self.Id = JSON[@"id"];
    self.pos_lat = JSON[@"pos_lat"];
    self.pos_lng = JSON[@"pos_lng"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.days!=nil){
        [res addObject:[self JSONItemFormat:@"\"days\":\"%@\"" data:self.days]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.pos_lat!=nil){
        [res addObject:[self JSONItemFormat:@"\"pos_lat\":\"%@\"" data:self.pos_lat]];
    }
    if(self.pos_lng!=nil){
        [res addObject:[self JSONItemFormat:@"\"pos_lng\":\"%@\"" data:self.pos_lng]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end
