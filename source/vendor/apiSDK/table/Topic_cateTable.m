/*
不要手动修改
*/
#import "Topic_cateTable.h"

@implementation Topic_cateTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.is_hots = [self stringFormat:JSON[@"is_hots"]];
    self.maxs = [self stringFormat:JSON[@"maxs"]];
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.pid = [self stringFormat:JSON[@"pid"]];
    self.remark = [self stringFormat:JSON[@"remark"]];
    self.seo_desc = [self stringFormat:JSON[@"seo_desc"]];
    self.seo_keys = [self stringFormat:JSON[@"seo_keys"]];
    self.seo_title = [self stringFormat:JSON[@"seo_title"]];
    self.spid = [self stringFormat:JSON[@"spid"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.update_time = [self stringFormat:JSON[@"update_time"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.img!=nil){
        [res addObject:[self JSONItemFormat:@"\"img\":\"%@\"" data:self.img]];
    }
    if(self.is_hots!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_hots\":\"%@\"" data:self.is_hots]];
    }
    if(self.maxs!=nil){
        [res addObject:[self JSONItemFormat:@"\"maxs\":\"%@\"" data:self.maxs]];
    }
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.ordid!=nil){
        [res addObject:[self JSONItemFormat:@"\"ordid\":\"%@\"" data:self.ordid]];
    }
    if(self.pid!=nil){
        [res addObject:[self JSONItemFormat:@"\"pid\":\"%@\"" data:self.pid]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    if(self.seo_desc!=nil){
        [res addObject:[self JSONItemFormat:@"\"seo_desc\":\"%@\"" data:self.seo_desc]];
    }
    if(self.seo_keys!=nil){
        [res addObject:[self JSONItemFormat:@"\"seo_keys\":\"%@\"" data:self.seo_keys]];
    }
    if(self.seo_title!=nil){
        [res addObject:[self JSONItemFormat:@"\"seo_title\":\"%@\"" data:self.seo_title]];
    }
    if(self.spid!=nil){
        [res addObject:[self JSONItemFormat:@"\"spid\":\"%@\"" data:self.spid]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.update_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"update_time\":\"%@\"" data:self.update_time]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end