/*
不要手动修改
*/
#import "PageInfoData.h"

@implementation PageInfoData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.page = [self stringFormat:JSON[@"page"]];
    self.perPage = [self stringFormat:JSON[@"perPage"]];
    self.totalPage = [self stringFormat:JSON[@"totalPage"]];
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