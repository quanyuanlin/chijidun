/*
不要手动修改
*/
#import "ExpressTable.h"

@implementation ExpressTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.code = [self stringFormat:JSON[@"code"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.status = [self stringFormat:JSON[@"status"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.code!=nil){
        [res addObject:[self JSONItemFormat:@"\"code\":\"%@\"" data:self.code]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end