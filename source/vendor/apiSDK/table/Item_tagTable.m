/*
不要手动修改
*/
#import "Item_tagTable.h"

@implementation Item_tagTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.item_id = [self stringFormat:JSON[@"item_id"]];
    self.tag_id = [self stringFormat:JSON[@"tag_id"]];
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
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    if(self.tag_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"tag_id\":\"%@\"" data:self.tag_id]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end