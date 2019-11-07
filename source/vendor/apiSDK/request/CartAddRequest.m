/*
不要手动修改
*/
#import "CartAddRequest.h"

@implementation CartAddRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.attr = JSON[@"attr"];
    self.days = JSON[@"days"];
    self.item_id = JSON[@"item_id"];
    self.num = JSON[@"num"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.attr!=nil){
        [res addObject:[self JSONItemFormat:@"\"attr\":\"%@\"" data:self.attr]];
    }
    if(self.days!=nil){
        [res addObject:[self JSONItemFormat:@"\"days\":\"%@\"" data:self.days]];
    }
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    if(self.num!=nil){
        [res addObject:[self JSONItemFormat:@"\"num\":\"%@\"" data:self.num]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end