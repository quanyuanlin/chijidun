/*
不要手动修改
*/
#import "Item_commentTable.h"

@implementation Item_commentTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.is_message = [self stringFormat:JSON[@"is_message"]];
    self.item_id = [self stringFormat:JSON[@"item_id"]];
    self.likes = [self stringFormat:JSON[@"likes"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.reply_id = [self stringFormat:JSON[@"reply_id"]];
    self.reply_info = [self stringFormat:JSON[@"reply_info"]];
    self.reply_name = [self stringFormat:JSON[@"reply_name"]];
    self.reply_time = [self stringFormat:JSON[@"reply_time"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    self.uname = [self stringFormat:JSON[@"uname"]];
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
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.is_message!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_message\":\"%@\"" data:self.is_message]];
    }
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    if(self.likes!=nil){
        [res addObject:[self JSONItemFormat:@"\"likes\":\"%@\"" data:self.likes]];
    }
    if(self.ordid!=nil){
        [res addObject:[self JSONItemFormat:@"\"ordid\":\"%@\"" data:self.ordid]];
    }
    if(self.reply_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"reply_id\":\"%@\"" data:self.reply_id]];
    }
    if(self.reply_info!=nil){
        [res addObject:[self JSONItemFormat:@"\"reply_info\":\"%@\"" data:self.reply_info]];
    }
    if(self.reply_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"reply_name\":\"%@\"" data:self.reply_name]];
    }
    if(self.reply_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"reply_time\":\"%@\"" data:self.reply_time]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"uid\":\"%@\"" data:self.uid]];
    }
    if(self.uname!=nil){
        [res addObject:[self JSONItemFormat:@"\"uname\":\"%@\"" data:self.uname]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end