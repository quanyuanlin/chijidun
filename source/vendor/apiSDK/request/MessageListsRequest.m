/*
不要手动修改
*/
#import "MessageListsRequest.h"

@implementation MessageListsRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.page = JSON[@"page"];
    self.perPage = JSON[@"perPage"];
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
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end