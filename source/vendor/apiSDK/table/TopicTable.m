/*
不要手动修改
*/
#import "TopicTable.h"

@implementation TopicTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.admin_id = [self stringFormat:JSON[@"admin_id"]];
    self.cate_id = [self stringFormat:JSON[@"cate_id"]];
    self.etime = [self stringFormat:JSON[@"etime"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.maxs = [self stringFormat:JSON[@"maxs"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.prices = [self stringFormat:JSON[@"prices"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.stime = [self stringFormat:JSON[@"stime"]];
    self.title = [self stringFormat:JSON[@"title"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.admin_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"admin_id\":\"%@\"" data:self.admin_id]];
    }
    if(self.cate_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"cate_id\":\"%@\"" data:self.cate_id]];
    }
    if(self.etime!=nil){
        [res addObject:[self JSONItemFormat:@"\"etime\":\"%@\"" data:self.etime]];
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
    if(self.maxs!=nil){
        [res addObject:[self JSONItemFormat:@"\"maxs\":\"%@\"" data:self.maxs]];
    }
    if(self.ordid!=nil){
        [res addObject:[self JSONItemFormat:@"\"ordid\":\"%@\"" data:self.ordid]];
    }
    if(self.prices!=nil){
        [res addObject:[self JSONItemFormat:@"\"prices\":\"%@\"" data:self.prices]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.stime!=nil){
        [res addObject:[self JSONItemFormat:@"\"stime\":\"%@\"" data:self.stime]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end