/*
不要手动修改
*/
#import "CartTable.h"

@implementation CartTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.attr = [self stringFormat:JSON[@"attr"]];
    self.days = [self stringFormat:JSON[@"days"]];
    self.express = [self stringFormat:JSON[@"express"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.item_id = [self stringFormat:JSON[@"item_id"]];
    self.item_img = [self stringFormat:JSON[@"item_img"]];
    self.item_title = [self stringFormat:JSON[@"item_title"]];
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.mname = [self stringFormat:JSON[@"mname"]];
    self.num = [self stringFormat:JSON[@"num"]];
    self.price = [self stringFormat:JSON[@"price"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.attr!=nil){
        [res addObject:[self JSONItemFormat:@"\"attr\":\"%@\"" data:self.attr]];
    }
    if(self.days!=nil){
        [res addObject:[self JSONItemFormat:@"\"days\":\"%@\"" data:self.days]];
    }
    if(self.express!=nil){
        [res addObject:[self JSONItemFormat:@"\"express\":\"%@\"" data:self.express]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    if(self.item_img!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_img\":\"%@\"" data:self.item_img]];
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
    if(self.num!=nil){
        [res addObject:[self JSONItemFormat:@"\"num\":\"%@\"" data:self.num]];
    }
    if(self.price!=nil){
        [res addObject:[self JSONItemFormat:@"\"price\":\"%@\"" data:self.price]];
    }
    if(self.uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"uid\":\"%@\"" data:self.uid]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end