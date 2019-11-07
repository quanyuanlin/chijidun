/*
不要手动修改
*/
#import "Member_giveTable.h"

@implementation Member_giveTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.card_id = [self stringFormat:JSON[@"card_id"]];
    self.check_name = [self stringFormat:JSON[@"check_name"]];
    self.check_remark = [self stringFormat:JSON[@"check_remark"]];
    self.check_time = [self stringFormat:JSON[@"check_time"]];
    self.check_uid = [self stringFormat:JSON[@"check_uid"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.mname = [self stringFormat:JSON[@"mname"]];
    self.money = [self stringFormat:JSON[@"money"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.total = [self stringFormat:JSON[@"total"]];
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
    if(self.check_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"check_name\":\"%@\"" data:self.check_name]];
    }
    if(self.check_remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"check_remark\":\"%@\"" data:self.check_remark]];
    }
    if(self.check_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"check_time\":\"%@\"" data:self.check_time]];
    }
    if(self.check_uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"check_uid\":\"%@\"" data:self.check_uid]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    if(self.mname!=nil){
        [res addObject:[self JSONItemFormat:@"\"mname\":\"%@\"" data:self.mname]];
    }
    if(self.money!=nil){
        [res addObject:[self JSONItemFormat:@"\"money\":\"%@\"" data:self.money]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.total!=nil){
        [res addObject:[self JSONItemFormat:@"\"total\":\"%@\"" data:self.total]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end