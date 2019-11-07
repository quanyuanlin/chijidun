/*
不要手动修改
*/
#import "OauthTable.h"

@implementation OauthTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.author = [self stringFormat:JSON[@"author"]];
    self.code = [self stringFormat:JSON[@"code"]];
    self.config = [self stringFormat:JSON[@"config"]];
    self.desc = [self stringFormat:JSON[@"desc"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.status = [self stringFormat:JSON[@"status"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.author!=nil){
        [res addObject:[self JSONItemFormat:@"\"author\":\"%@\"" data:self.author]];
    }
    if(self.code!=nil){
        [res addObject:[self JSONItemFormat:@"\"code\":\"%@\"" data:self.code]];
    }
    if(self.config!=nil){
        [res addObject:[self JSONItemFormat:@"\"config\":\"%@\"" data:self.config]];
    }
    if(self.desc!=nil){
        [res addObject:[self JSONItemFormat:@"\"desc\":\"%@\"" data:self.desc]];
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