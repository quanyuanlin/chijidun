/*
不要手动修改
*/
#import "LikeTable.h"

@implementation LikeTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.status = [self stringFormat:JSON[@"status"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.img!=nil){
        [res addObject:[self JSONItemFormat:@"\"img\":\"%@\"" data:self.img]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.ordid!=nil){
        [res addObject:[self JSONItemFormat:@"\"ordid\":\"%@\"" data:self.ordid]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end