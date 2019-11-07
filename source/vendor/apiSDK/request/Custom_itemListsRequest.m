/*
不要手动修改
*/
#import "Custom_itemListsRequest.h"

@implementation Custom_itemListsRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.page = JSON[@"page"];
    self.perPage = JSON[@"perPage"];
    self.totalPage = JSON[@"totalPage"];
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
    if(self.totalPage!=nil){
        [res addObject:[self JSONItemFormat:@"\"totalPage\":\"%@\"" data:self.totalPage]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end