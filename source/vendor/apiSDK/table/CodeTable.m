/*
不要手动修改
*/
#import "CodeTable.h"

@implementation CodeTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.code = [self stringFormat:JSON[@"code"]];
    self.ctime = [self stringFormat:JSON[@"ctime"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.tele = [self stringFormat:JSON[@"tele"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.code!=nil){
        [res addObject:[self JSONItemFormat:@"\"code\":\"%@\"" data:self.code]];
    }
    if(self.ctime!=nil){
        [res addObject:[self JSONItemFormat:@"\"ctime\":\"%@\"" data:self.ctime]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"tele\":\"%@\"" data:self.tele]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end