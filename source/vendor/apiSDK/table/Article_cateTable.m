/*
不要手动修改
*/
#import "Article_cateTable.h"

@implementation Article_cateTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.alias = [self stringFormat:JSON[@"alias"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.pid = [self stringFormat:JSON[@"pid"]];
    self.seo_desc = [self stringFormat:JSON[@"seo_desc"]];
    self.seo_keys = [self stringFormat:JSON[@"seo_keys"]];
    self.seo_title = [self stringFormat:JSON[@"seo_title"]];
    self.spid = [self stringFormat:JSON[@"spid"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.type = [self stringFormat:JSON[@"type"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.alias!=nil){
        [res addObject:[self JSONItemFormat:@"\"alias\":\"%@\"" data:self.alias]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.img!=nil){
        [res addObject:[self JSONItemFormat:@"\"img\":\"%@\"" data:self.img]];
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
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end