/*
不要手动修改
*/
#import "AdTable.h"

@implementation AdTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.board_id = [self stringFormat:JSON[@"board_id"]];
    self.clicks = [self stringFormat:JSON[@"clicks"]];
    self.content = [self stringFormat:JSON[@"content"]];
    self.desc = [self stringFormat:JSON[@"desc"]];
    self.end_time = [self stringFormat:JSON[@"end_time"]];
    self.extimg = [self stringFormat:JSON[@"extimg"]];
    self.extval = [self stringFormat:JSON[@"extval"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.start_time = [self stringFormat:JSON[@"start_time"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.type = [self stringFormat:JSON[@"type"]];
    self.url = [self stringFormat:JSON[@"url"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.board_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"board_id\":\"%@\"" data:self.board_id]];
    }
    if(self.clicks!=nil){
        [res addObject:[self JSONItemFormat:@"\"clicks\":\"%@\"" data:self.clicks]];
    }
    if(self.content!=nil){
        [res addObject:[self JSONItemFormat:@"\"content\":\"%@\"" data:self.content]];
    }
    if(self.desc!=nil){
        [res addObject:[self JSONItemFormat:@"\"desc\":\"%@\"" data:self.desc]];
    }
    if(self.end_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"end_time\":\"%@\"" data:self.end_time]];
    }
    if(self.extimg!=nil){
        [res addObject:[self JSONItemFormat:@"\"extimg\":\"%@\"" data:self.extimg]];
    }
    if(self.extval!=nil){
        [res addObject:[self JSONItemFormat:@"\"extval\":\"%@\"" data:self.extval]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.ordid!=nil){
        [res addObject:[self JSONItemFormat:@"\"ordid\":\"%@\"" data:self.ordid]];
    }
    if(self.start_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"start_time\":\"%@\"" data:self.start_time]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    if(self.url!=nil){
        [res addObject:[self JSONItemFormat:@"\"url\":\"%@\"" data:self.url]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end