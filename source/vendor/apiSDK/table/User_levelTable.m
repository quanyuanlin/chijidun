/*
不要手动修改
*/
#import "User_levelTable.h"

@implementation User_levelTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.Id = [self stringFormat:JSON[@"id"]];
    self.max = [self stringFormat:JSON[@"max"]];
    self.min = [self stringFormat:JSON[@"min"]];
    self.title = [self stringFormat:JSON[@"title"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.max!=nil){
        [res addObject:[self JSONItemFormat:@"\"max\":\"%@\"" data:self.max]];
    }
    if(self.min!=nil){
        [res addObject:[self JSONItemFormat:@"\"min\":\"%@\"" data:self.min]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end