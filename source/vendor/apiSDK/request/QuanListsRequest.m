/*
不要手动修改
*/
#import "QuanListsRequest.h"

@implementation QuanListsRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.order = JSON[@"order"];
    self.order_by = JSON[@"order_by"];
    self.order_user = JSON[@"order_user"];
    self.page = JSON[@"page"];
    self.perPage = JSON[@"perPage"];
    self.type = JSON[@"type"];
    self.used_status = JSON[@"used_status"];
    self.used_uid = JSON[@"used_uid"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.order!=nil){
        [res addObject:[self JSONItemFormat:@"\"order\":\"%@\"" data:self.order]];
    }
    if(self.order_by!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_by\":\"%@\"" data:self.order_by]];
    }
    if(self.order_user!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_user\":\"%@\"" data:self.order_user]];
    }
    if(self.page!=nil){
        [res addObject:[self JSONItemFormat:@"\"page\":\"%@\"" data:self.page]];
    }
    if(self.perPage!=nil){
        [res addObject:[self JSONItemFormat:@"\"perPage\":\"%@\"" data:self.perPage]];
    }
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    if(self.used_status!=nil){
        [res addObject:[self JSONItemFormat:@"\"used_status\":\"%@\"" data:self.used_status]];
    }
    if(self.used_uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"used_uid\":\"%@\"" data:self.used_uid]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end