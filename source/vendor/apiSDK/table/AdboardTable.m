/*
不要手动修改
*/
#import "AdboardTable.h"

@implementation AdboardTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.description = [self stringFormat:JSON[@"description"]];
    self.height = [self stringFormat:JSON[@"height"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.tpl = [self stringFormat:JSON[@"tpl"]];
    self.type = [self stringFormat:JSON[@"type"]];
    self.width = [self stringFormat:JSON[@"width"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.description!=nil){
        [res addObject:[self JSONItemFormat:@"\"description\":\"%@\"" data:self.description]];
    }
    if(self.height!=nil){
        [res addObject:[self JSONItemFormat:@"\"height\":\"%@\"" data:self.height]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.tpl!=nil){
        [res addObject:[self JSONItemFormat:@"\"tpl\":\"%@\"" data:self.tpl]];
    }
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    if(self.width!=nil){
        [res addObject:[self JSONItemFormat:@"\"width\":\"%@\"" data:self.width]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end