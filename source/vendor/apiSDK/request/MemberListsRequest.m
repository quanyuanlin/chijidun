/*
不要手动修改
*/
#import "MemberListsRequest.h"

@implementation MemberListsRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.page = JSON[@"page"];
    self.perPage = JSON[@"perPage"];
    self.pos_lat = JSON[@"pos_lat"];
    self.pos_lng = JSON[@"pos_lng"];
    self.city = JSON[@"city"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.page!=nil){
        [res addObject:[self JSONItemFormat:@"\"page\":\"%@\"" data:self.page]];
    }
    if(self.perPage!=nil){
        [res addObject:[self JSONItemFormat:@"\"perPage\":\"%@\"" data:self.perPage]];
    }
    if(self.pos_lat!=nil){
        [res addObject:[self JSONItemFormat:@"\"pos_lat\":\"%@\"" data:self.pos_lat]];
    }
    if(self.pos_lng!=nil){
        [res addObject:[self JSONItemFormat:@"\"pos_lng\":\"%@\"" data:self.pos_lng]];
    }
    if(self.city!=nil){
        [res addObject:[self JSONItemFormat:@"\"city\":\"%@\"" data:self.city]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end
