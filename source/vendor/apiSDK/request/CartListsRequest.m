/*
不要手动修改
*/
#import "CartListsRequest.h"

@implementation CartListsRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.days = JSON[@"days"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.days!=nil){
        [res addObject:[self JSONItemFormat:@"\"days\":\"%@\"" data:self.days]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end