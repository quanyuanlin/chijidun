/*
不要手动修改
*/
#import "Member_cardTable.h"

@implementation Member_cardTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.card_id = [self stringFormat:JSON[@"card_id"]];
    self.card_no = [self stringFormat:JSON[@"card_no"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.is_default = [self stringFormat:JSON[@"is_default"]];
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.real_fname = [self stringFormat:JSON[@"real_fname"]];
    self.real_name = [self stringFormat:JSON[@"real_name"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.card_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"card_id\":\"%@\"" data:self.card_id]];
    }
    if(self.card_no!=nil){
        [res addObject:[self JSONItemFormat:@"\"card_no\":\"%@\"" data:self.card_no]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.is_default!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_default\":\"%@\"" data:self.is_default]];
    }
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.real_fname!=nil){
        [res addObject:[self JSONItemFormat:@"\"real_fname\":\"%@\"" data:self.real_fname]];
    }
    if(self.real_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"real_name\":\"%@\"" data:self.real_name]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end