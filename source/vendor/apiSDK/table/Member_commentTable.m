/*
不要手动修改
*/
#import "Member_commentTable.h"

@implementation Member_commentTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    NSMutableArray *imgsArray =[self arrayFormat:JSON[@"imgs"]];
    self.imgs=[NSMutableArray new];
    if (imgsArray && imgsArray.count > 0) {
        for (NSMutableDictionary *item in imgsArray)
            [self.imgs addObject:[[[Member_comment_imgTable alloc]init]fromJSON:item]];
    }   
    self.info = [self stringFormat:JSON[@"info"]];
    self.item_id = [self stringFormat:JSON[@"item_id"]];
    self.likes = [self stringFormat:JSON[@"likes"]];
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.order_type = [self stringFormat:JSON[@"order_type"]];
    self.orderid = [self stringFormat:JSON[@"orderid"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.reply_id = [self stringFormat:JSON[@"reply_id"]];
    self.reply_info = [self stringFormat:JSON[@"reply_info"]];
    self.reply_name = [self stringFormat:JSON[@"reply_name"]];
    self.reply_time = [self stringFormat:JSON[@"reply_time"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    self.uname = [self stringFormat:JSON[@"uname"]];
    self.user =[[UserTable new]fromJSON:JSON[@"user"]];
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
    NSMutableArray *imgsList = [NSMutableArray new];
        for (Member_comment_imgTable *item in self.imgs)
            [imgsList addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"imgs\":[%@]",[imgsList componentsJoinedByString:@","]]];
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    if(self.likes!=nil){
        [res addObject:[self JSONItemFormat:@"\"likes\":\"%@\"" data:self.likes]];
    }
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    if(self.order_type!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_type\":\"%@\"" data:self.order_type]];
    }
    if(self.orderid!=nil){
        [res addObject:[self JSONItemFormat:@"\"orderid\":\"%@\"" data:self.orderid]];
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
    if(self.user!=nil){
        [res addObject:[NSString stringWithFormat:@"\"user\":%@",[self.user toJSON]]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end