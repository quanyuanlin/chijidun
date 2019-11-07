/*
不要手动修改
*/
#import "Article_pageTable.h"

@implementation Article_pageTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.cate_id = [self stringFormat:JSON[@"cate_id"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.last_time = [self stringFormat:JSON[@"last_time"]];
    self.seo_desc = [self stringFormat:JSON[@"seo_desc"]];
    self.seo_keys = [self stringFormat:JSON[@"seo_keys"]];
    self.seo_title = [self stringFormat:JSON[@"seo_title"]];
    self.title = [self stringFormat:JSON[@"title"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.cate_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"cate_id\":\"%@\"" data:self.cate_id]];
    }
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.last_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"last_time\":\"%@\"" data:self.last_time]];
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
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end