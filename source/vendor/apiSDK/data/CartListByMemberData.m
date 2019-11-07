/*
不要手动修改
*/
#import "CartListByMemberData.h"

@implementation CartListByMemberData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.amount = [self stringFormat:JSON[@"amount"]];
    self.etime = [self stringFormat:JSON[@"etime"]];
    self.is_open = [self stringFormat:JSON[@"is_open"]];
    NSMutableArray *item_listArray =[self arrayFormat:JSON[@"item_list"]];
    self.item_list=[NSMutableArray new];
    if (item_listArray && item_listArray.count > 0) {
        for (NSMutableDictionary *item in item_listArray)
            [self.item_list addObject:[[[CartTable alloc]init]fromJSON:item]];
    }   
    self.mid = [self stringFormat:JSON[@"mid"]];
    self.min_price = [self stringFormat:JSON[@"min_price"]];
    self.mname = [self stringFormat:JSON[@"mname"]];
    self.stime = [self stringFormat:JSON[@"stime"]];
    self.weeks = [self stringFormat:JSON[@"weeks"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.amount!=nil){
        [res addObject:[self JSONItemFormat:@"\"amount\":\"%@\"" data:self.amount]];
    }
    if(self.etime!=nil){
        [res addObject:[self JSONItemFormat:@"\"etime\":\"%@\"" data:self.etime]];
    }
    if(self.is_open!=nil){
        [res addObject:[self JSONItemFormat:@"\"is_open\":\"%@\"" data:self.is_open]];
    }
    NSMutableArray *item_listList = [NSMutableArray new];
        for (CartTable *item in self.item_list)
            [item_listList addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"item_list\":[%@]",[item_listList componentsJoinedByString:@","]]];
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    if(self.min_price!=nil){
        [res addObject:[self JSONItemFormat:@"\"min_price\":\"%@\"" data:self.min_price]];
    }
    if(self.mname!=nil){
        [res addObject:[self JSONItemFormat:@"\"mname\":\"%@\"" data:self.mname]];
    }
    if(self.stime!=nil){
        [res addObject:[self JSONItemFormat:@"\"stime\":\"%@\"" data:self.stime]];
    }
    if(self.weeks!=nil){
        [res addObject:[self JSONItemFormat:@"\"weeks\":\"%@\"" data:self.weeks]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end