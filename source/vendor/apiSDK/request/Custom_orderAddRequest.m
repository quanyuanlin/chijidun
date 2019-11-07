/*
不要手动修改
*/
#import "Custom_orderAddRequest.h"

@implementation Custom_orderAddRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.address = JSON[@"address"];
    self.fruit = JSON[@"fruit"];
    self.item_id = JSON[@"item_id"];
    self.meat = JSON[@"meat"];
    self.name = JSON[@"name"];
    self.nums = JSON[@"nums"];
    self.price = JSON[@"price"];
    self.remark = JSON[@"remark"];
    self.soup = JSON[@"soup"];
    self.tele = JSON[@"tele"];
    self.times = JSON[@"times"];
    self.vege = JSON[@"vege"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.address!=nil){
        [res addObject:[self JSONItemFormat:@"\"address\":\"%@\"" data:self.address]];
    }
    if(self.fruit!=nil){
        [res addObject:[self JSONItemFormat:@"\"fruit\":\"%@\"" data:self.fruit]];
    }
    if(self.item_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"item_id\":\"%@\"" data:self.item_id]];
    }
    if(self.meat!=nil){
        [res addObject:[self JSONItemFormat:@"\"meat\":\"%@\"" data:self.meat]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.nums!=nil){
        [res addObject:[self JSONItemFormat:@"\"nums\":\"%@\"" data:self.nums]];
    }
    if(self.price!=nil){
        [res addObject:[self JSONItemFormat:@"\"price\":\"%@\"" data:self.price]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    if(self.soup!=nil){
        [res addObject:[self JSONItemFormat:@"\"soup\":\"%@\"" data:self.soup]];
    }
    if(self.tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"tele\":\"%@\"" data:self.tele]];
    }
    if(self.times!=nil){
        [res addObject:[self JSONItemFormat:@"\"times\":\"%@\"" data:self.times]];
    }
    if(self.vege!=nil){
        [res addObject:[self JSONItemFormat:@"\"vege\":\"%@\"" data:self.vege]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end