/*
不要手动修改
*/
#import "QuanTable.h"

@implementation QuanTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.code = [self stringFormat:JSON[@"code"]];
    self.etime = [self stringFormat:JSON[@"etime"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.item_id = [self stringFormat:JSON[@"item_id"]];
    self.man_price = [self stringFormat:JSON[@"man_price"]];
    self.man_sale = [self stringFormat:JSON[@"man_sale"]];
    self.max = [self stringFormat:JSON[@"max"]];
    self.price = [self stringFormat:JSON[@"price"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.stime = [self stringFormat:JSON[@"stime"]];
    self.title = [self stringFormat:JSON[@"title"]];
    self.type = [self stringFormat:JSON[@"type"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    self.uname = [self stringFormat:JSON[@"uname"]];
    self.used_status = [self stringFormat:JSON[@"used_status"]];
    self.used_time = [self stringFormat:JSON[@"used_time"]];
    self.used_uid = [self stringFormat:JSON[@"used_uid"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.code!=nil){
        [res addObject:[self JSONItemFormat:@"\"code\":\"%@\"" data:self.code]];
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
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    if(self.man_price!=nil){
        [res addObject:[self JSONItemFormat:@"\"man_price\":\"%@\"" data:self.man_price]];
    }
    if(self.man_sale!=nil){
        [res addObject:[self JSONItemFormat:@"\"man_sale\":\"%@\"" data:self.man_sale]];
    }
    if(self.max!=nil){
        [res addObject:[self JSONItemFormat:@"\"max\":\"%@\"" data:self.max]];
    }
    if(self.price!=nil){
        [res addObject:[self JSONItemFormat:@"\"price\":\"%@\"" data:self.price]];
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
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    if(self.uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"uid\":\"%@\"" data:self.uid]];
    }
    if(self.uname!=nil){
        [res addObject:[self JSONItemFormat:@"\"uname\":\"%@\"" data:self.uname]];
    }
    if(self.used_status!=nil){
        [res addObject:[self JSONItemFormat:@"\"used_status\":\"%@\"" data:self.used_status]];
    }
    if(self.used_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"used_time\":\"%@\"" data:self.used_time]];
    }
    if(self.used_uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"used_uid\":\"%@\"" data:self.used_uid]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end