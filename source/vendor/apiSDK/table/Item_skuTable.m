/*
不要手动修改
*/
#import "Item_skuTable.h"

@implementation Item_skuTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.cate_id = [self stringFormat:JSON[@"cate_id"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.nums = [self stringFormat:JSON[@"nums"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.cate_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"cate_id\":\"%@\"" data:self.cate_id]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.nums!=nil){
        [res addObject:[self JSONItemFormat:@"\"nums\":\"%@\"" data:self.nums]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end