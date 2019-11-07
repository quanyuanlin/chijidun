/*
不要手动修改
*/
#import "MeetTable.h"

@implementation MeetTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.abst = [self stringFormat:JSON[@"abst"]];
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.price = [self stringFormat:JSON[@"price"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.title = [self stringFormat:JSON[@"title"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.abst!=nil){
        [res addObject:[self JSONItemFormat:@"\"abst\":\"%@\"" data:self.abst]];
    }
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.img!=nil){
        [res addObject:[self JSONItemFormat:@"\"img\":\"%@\"" data:self.img]];
    }
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.ordid!=nil){
        [res addObject:[self JSONItemFormat:@"\"ordid\":\"%@\"" data:self.ordid]];
    }
    if(self.price!=nil){
        [res addObject:[self JSONItemFormat:@"\"price\":\"%@\"" data:self.price]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end