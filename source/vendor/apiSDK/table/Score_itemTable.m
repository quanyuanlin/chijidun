/*
不要手动修改
*/
#import "Score_itemTable.h"

@implementation Score_itemTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.buy_num = [self stringFormat:JSON[@"buy_num"]];
    self.cate_id = [self stringFormat:JSON[@"cate_id"]];
    self.desc = [self stringFormat:JSON[@"desc"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.score = [self stringFormat:JSON[@"score"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.stock = [self stringFormat:JSON[@"stock"]];
    self.title = [self stringFormat:JSON[@"title"]];
    self.type = [self stringFormat:JSON[@"type"]];
    self.user_num = [self stringFormat:JSON[@"user_num"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.buy_num!=nil){
        [res addObject:[self JSONItemFormat:@"\"buy_num\":\"%@\"" data:self.buy_num]];
    }
    if(self.cate_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"cate_id\":\"%@\"" data:self.cate_id]];
    }
    if(self.desc!=nil){
        [res addObject:[self JSONItemFormat:@"\"desc\":\"%@\"" data:self.desc]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.img!=nil){
        [res addObject:[self JSONItemFormat:@"\"img\":\"%@\"" data:self.img]];
    }
    if(self.ordid!=nil){
        [res addObject:[self JSONItemFormat:@"\"ordid\":\"%@\"" data:self.ordid]];
    }
    if(self.score!=nil){
        [res addObject:[self JSONItemFormat:@"\"score\":\"%@\"" data:self.score]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.stock!=nil){
        [res addObject:[self JSONItemFormat:@"\"stock\":\"%@\"" data:self.stock]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    if(self.user_num!=nil){
        [res addObject:[self JSONItemFormat:@"\"user_num\":\"%@\"" data:self.user_num]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end