/*
不要手动修改
*/
#import "CartDeleteRequest.h"

@implementation CartDeleteRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    NSMutableArray *itemsArray =[self arrayFormat:JSON[@"items"]];
    self.items=[NSMutableArray new];
    if (itemsArray && itemsArray.count > 0) {
        for (NSMutableDictionary *item in itemsArray)
            [self.items addObject:[[[CartDeleteParamsData alloc]init]fromJSON:item]];
    }   
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    NSMutableArray *itemsList = [NSMutableArray new];
        for (CartDeleteParamsData *item in self.items)
            [itemsList addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"items\":[%@]",[itemsList componentsJoinedByString:@","]]];
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end