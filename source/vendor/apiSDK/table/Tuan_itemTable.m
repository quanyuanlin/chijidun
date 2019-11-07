/*
不要手动修改
*/
#import "Tuan_itemTable.h"

@implementation Tuan_itemTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.Id = [self stringFormat:JSON[@"id"]];
    self.item_id = [self stringFormat:JSON[@"item_id"]];
    self.item_title = [self stringFormat:JSON[@"item_title"]];
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.mname = [self stringFormat:JSON[@"mname"]];
    self.nums = [self stringFormat:JSON[@"nums"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.pos_lat = [self stringFormat:JSON[@"pos_lat"]];
    self.pos_lng = [self stringFormat:JSON[@"pos_lng"]];
    self.tuan_id = [self stringFormat:JSON[@"tuan_id"]];
    self.type = [self stringFormat:JSON[@"type"]];
    self.units = [self stringFormat:JSON[@"units"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    if(self.item_title!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_title\":\"%@\"" data:self.item_title]];
    }
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    if(self.mname!=nil){
        [res addObject:[self JSONItemFormat:@"\"mname\":\"%@\"" data:self.mname]];
    }
    if(self.nums!=nil){
        [res addObject:[self JSONItemFormat:@"\"nums\":\"%@\"" data:self.nums]];
    }
    if(self.ordid!=nil){
        [res addObject:[self JSONItemFormat:@"\"ordid\":\"%@\"" data:self.ordid]];
    }
    if(self.pos_lat!=nil){
        [res addObject:[self JSONItemFormat:@"\"pos_lat\":\"%@\"" data:self.pos_lat]];
    }
    if(self.pos_lng!=nil){
        [res addObject:[self JSONItemFormat:@"\"pos_lng\":\"%@\"" data:self.pos_lng]];
    }
    if(self.tuan_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"tuan_id\":\"%@\"" data:self.tuan_id]];
    }
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    if(self.units!=nil){
        [res addObject:[self JSONItemFormat:@"\"units\":\"%@\"" data:self.units]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end