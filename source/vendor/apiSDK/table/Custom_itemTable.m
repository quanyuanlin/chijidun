/*
不要手动修改
*/
#import "Custom_itemTable.h"

@implementation Custom_itemTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.abst = [self stringFormat:JSON[@"abst"]];
    self.fruit = [self stringFormat:JSON[@"fruit"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.info = [self stringFormat:JSON[@"info"]];
    self.meat = [self stringFormat:JSON[@"meat"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.orders = [self stringFormat:JSON[@"orders"]];
    self.ordid = [self stringFormat:JSON[@"ordid"]];
    self.price = [self stringFormat:JSON[@"price"]];
    self.soup = [self stringFormat:JSON[@"soup"]];
    self.status = [self stringFormat:JSON[@"status"]];
    self.vege = [self stringFormat:JSON[@"vege"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.abst!=nil){
        [res addObject:[self JSONItemFormat:@"\"abst\":\"%@\"" data:self.abst]];
    }
    if(self.fruit!=nil){
        [res addObject:[self JSONItemFormat:@"\"fruit\":\"%@\"" data:self.fruit]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.img!=nil){
        [res addObject:[self JSONItemFormat:@"\"img\":\"%@\"" data:self.img]];
    }
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.meat!=nil){
        [res addObject:[self JSONItemFormat:@"\"meat\":\"%@\"" data:self.meat]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.orders!=nil){
        [res addObject:[self JSONItemFormat:@"\"orders\":\"%@\"" data:self.orders]];
    }
    if(self.ordid!=nil){
        [res addObject:[self JSONItemFormat:@"\"ordid\":\"%@\"" data:self.ordid]];
    }
    if(self.price!=nil){
        [res addObject:[self JSONItemFormat:@"\"price\":\"%@\"" data:self.price]];
    }
    if(self.soup!=nil){
        [res addObject:[self JSONItemFormat:@"\"soup\":\"%@\"" data:self.soup]];
    }
    if(self.status!=nil){
        [res addObject:[self JSONItemFormat:@"\"status\":\"%@\"" data:self.status]];
    }
    if(self.vege!=nil){
        [res addObject:[self JSONItemFormat:@"\"vege\":\"%@\"" data:self.vege]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end