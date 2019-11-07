/*
不要手动修改
*/
#import "CartListsData.h"

@implementation CartListsData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    NSMutableArray *listArray =[self arrayFormat:JSON[@"list"]];
    self.list=[NSMutableArray new];
    if (listArray && listArray.count > 0) {
        for (NSMutableDictionary *item in listArray)
            [self.list addObject:[[[CartListByMemberData alloc]init]fromJSON:item]];
    }   
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    NSMutableArray *listList = [NSMutableArray new];
        for (CartListByMemberData *item in self.list)
            [listList addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"list\":[%@]",[listList componentsJoinedByString:@","]]];
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end