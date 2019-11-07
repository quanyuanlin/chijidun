/*
不要手动修改
*/
#import "MaterialTable.h"

@implementation MaterialTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.desc = [self stringFormat:JSON[@"desc"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.img = [self stringFormat:JSON[@"img"]];
    self.original_price = [self stringFormat:JSON[@"original_price"]];
    self.price = [self stringFormat:JSON[@"price"]];
    self.stock = [self stringFormat:JSON[@"stock"]];
    self.title = [self stringFormat:JSON[@"title"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.desc!=nil){
        [res addObject:[self JSONItemFormat:@"\"desc\":\"%@\"" data:self.desc]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.img!=nil){
        [res addObject:[self JSONItemFormat:@"\"img\":\"%@\"" data:self.img]];
    }
    if(self.original_price!=nil){
        [res addObject:[self JSONItemFormat:@"\"original_price\":\"%@\"" data:self.original_price]];
    }
    if(self.price!=nil){
        [res addObject:[self JSONItemFormat:@"\"price\":\"%@\"" data:self.price]];
    }
    if(self.stock!=nil){
        [res addObject:[self JSONItemFormat:@"\"stock\":\"%@\"" data:self.stock]];
    }
    if(self.title!=nil){
        [res addObject:[self JSONItemFormat:@"\"title\":\"%@\"" data:self.title]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end