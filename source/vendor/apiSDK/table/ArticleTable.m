/*
不要手动修改
*/
#import "ArticleTable.h"

@implementation ArticleTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.author = [self stringFormat:JSON[@"author"]];
    self.cate_id = [self stringFormat:JSON[@"cate_id"]];
    self.colors = [self stringFormat:JSON[@"colors"]];
    self.comments = [self stringFormat:JSON[@"comments"]];
    self.hits = [self stringFormat:JSON[@"hits"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.intro = [self stringFormat:JSON[@"intro"]];
    self.last_time = [self stringFormat:JSON[@"last_time"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.seo_desc = [self stringFormat:JSON[@"seo_desc"]];
    self.seo_keys = [self stringFormat:JSON[@"seo_keys"]];
    self.seo_title = [self stringFormat:JSON[@"seo_title"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.tags = [self stringFormat:JSON[@"tags"]];
    self.title = [self stringFormat:JSON[@"title"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.author!=nil){
        [res addObject:[self JSONItemFormat:@"\"author\":\"%@\"" data:self.author]];
    }
    if(self.cate_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"cate_id\":\"%@\"" data:self.cate_id]];
    }
    if(self.colors!=nil){
        [res addObject:[self JSONItemFormat:@"\"colors\":\"%@\"" data:self.colors]];
    }
    if(self.comments!=nil){
        [res addObject:[self JSONItemFormat:@"\"comments\":\"%@\"" data:self.comments]];
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
    if(self.intro!=nil){
        [res addObject:[self JSONItemFormat:@"\"intro\":\"%@\"" data:self.intro]];
    }
    if(self.last_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"last_time\":\"%@\"" data:self.last_time]];
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
    if(self.tags!=nil){
        [res addObject:[self JSONItemFormat:@"\"tags\":\"%@\"" data:self.tags]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end