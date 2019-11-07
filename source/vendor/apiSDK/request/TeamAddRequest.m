/*
不要手动修改
*/
#import "TeamAddRequest.h"

@implementation TeamAddRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.address = JSON[@"address"];
    self.area = JSON[@"area"];
    self.city = JSON[@"city"];
    self.invoice = JSON[@"invoice"];
    self.name = JSON[@"name"];
    self.names = JSON[@"names"];
    self.nums = JSON[@"nums"];
    self.price = JSON[@"price"];
    self.province = JSON[@"province"];
    self.remark = JSON[@"remark"];
    self.team_name = JSON[@"team_name"];
    self.tele = JSON[@"tele"];
    self.times = JSON[@"times"];
    self.type = JSON[@"type"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.address!=nil){
        [res addObject:[self JSONItemFormat:@"\"address\":\"%@\"" data:self.address]];
    }
    if(self.area!=nil){
        [res addObject:[self JSONItemFormat:@"\"area\":\"%@\"" data:self.area]];
    }
    if(self.city!=nil){
        [res addObject:[self JSONItemFormat:@"\"city\":\"%@\"" data:self.city]];
    }
    if(self.invoice!=nil){
        [res addObject:[self JSONItemFormat:@"\"invoice\":\"%@\"" data:self.invoice]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.names!=nil){
        [res addObject:[self JSONItemFormat:@"\"names\":\"%@\"" data:self.names]];
    }
    if(self.nums!=nil){
        [res addObject:[self JSONItemFormat:@"\"nums\":\"%@\"" data:self.nums]];
    }
    if(self.price!=nil){
        [res addObject:[self JSONItemFormat:@"\"price\":\"%@\"" data:self.price]];
    }
    if(self.province!=nil){
        [res addObject:[self JSONItemFormat:@"\"province\":\"%@\"" data:self.province]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    if(self.team_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"team_name\":\"%@\"" data:self.team_name]];
    }
    if(self.tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"tele\":\"%@\"" data:self.tele]];
    }
    if(self.times!=nil){
        [res addObject:[self JSONItemFormat:@"\"times\":\"%@\"" data:self.times]];
    }
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end