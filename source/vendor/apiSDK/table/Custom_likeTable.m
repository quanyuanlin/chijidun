/*
不要手动修改
*/
#import "Custom_likeTable.h"

@implementation Custom_likeTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.custom_id = [self stringFormat:JSON[@"custom_id"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.like_id = [self stringFormat:JSON[@"like_id"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.custom_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"custom_id\":\"%@\"" data:self.custom_id]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.like_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"like_id\":\"%@\"" data:self.like_id]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end