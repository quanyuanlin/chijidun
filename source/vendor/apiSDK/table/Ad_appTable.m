/*
不要手动修改
*/
#import "Ad_appTable.h"

@implementation Ad_appTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.link_url = [self stringFormat:JSON[@"link_url"]];
    self.share_desc = [self stringFormat:JSON[@"share_desc"]];
    self.share_icon = [self stringFormat:JSON[@"share_icon"]];
    self.share_title = [self stringFormat:JSON[@"share_title"]];
    self.share_url = [self stringFormat:JSON[@"share_url"]];
    self.banner_img= [self stringFormat:JSON[@"banner_img"]];
    self.title= [self stringFormat:JSON[@"title"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.link_url!=nil){
        [res addObject:[self JSONItemFormat:@"\"link_url\":\"%@\"" data:self.link_url]];
    }
    if(self.share_desc!=nil){
        [res addObject:[self JSONItemFormat:@"\"share_desc\":\"%@\"" data:self.share_desc]];
    }
    if(self.share_icon!=nil){
        [res addObject:[self JSONItemFormat:@"\"share_icon\":\"%@\"" data:self.share_icon]];
    }
    if(self.share_title!=nil){
        [res addObject:[self JSONItemFormat:@"\"share_title\":\"%@\"" data:self.share_title]];
    }
    if(self.share_url!=nil){
        [res addObject:[self JSONItemFormat:@"\"share_url\":\"%@\"" data:self.share_url]];
    }
    if(self.banner_img!=nil){
        [res addObject:[self JSONItemFormat:@"\"banner_img\":\"%@\"" data:self.banner_img]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end
