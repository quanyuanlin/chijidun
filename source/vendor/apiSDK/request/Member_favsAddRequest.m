/*
不要手动修改
*/
#import "Member_favsAddRequest.h"

@implementation Member_favsAddRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.mid = JSON[@"mid"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end