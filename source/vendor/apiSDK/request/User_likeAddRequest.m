/*
不要手动修改
*/
#import "User_likeAddRequest.h"

@implementation User_likeAddRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.item_id = JSON[@"item_id"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end