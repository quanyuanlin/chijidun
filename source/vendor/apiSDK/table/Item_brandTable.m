/*
不要手动修改
*/
#import "Item_brandTable.h"

@implementation Item_brandTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.abst = [self stringFormat:JSON[@"abst"]];
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.address = [self stringFormat:JSON[@"address"]];
    self.hits = [self stringFormat:JSON[@"hits"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.seo_desc = [self stringFormat:JSON[@"seo_desc"]];
    self.seo_keys = [self stringFormat:JSON[@"seo_keys"]];
    self.seo_title = [self stringFormat:JSON[@"seo_title"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.tele = [self stringFormat:JSON[@"tele"]];
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
    if(self.address!=nil){
        [res addObject:[self JSONItemFormat:@"\"address\":\"%@\"" data:self.address]];
    }
    if(self.hits!=nil){
        [res addObject:[self JSONItemFormat:@"\"hits\":\"%@\"" data:self.hits]];
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
    if(self.seo_desc!=nil){
        [res addObject:[self JSONItemFormat:@"\"seo_desc\":\"%@\"" data:self.seo_desc]];
    }
    if(self.seo_keys!=nil){
        [res addObject:[self JSONItemFormat:@"\"seo_keys\":\"%@\"" data:self.seo_keys]];
    }
    if(self.seo_title!=nil){
        [res addObject:[self JSONItemFormat:@"\"seo_title\":\"%@\"" data:self.seo_title]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"tele\":\"%@\"" data:self.tele]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end