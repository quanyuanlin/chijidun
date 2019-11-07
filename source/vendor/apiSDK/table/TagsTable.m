/*
不要手动修改
*/
#import "TagsTable.h"

@implementation TagsTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.cate_id = [self stringFormat:JSON[@"cate_id"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.status = [self stringFormat:JSON[@"status"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.cate_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"cate_id\":\"%@\"" data:self.cate_id]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
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