/*
不要手动修改
*/
#import "Custom_itemListsData.h"

@implementation Custom_itemListsData 

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
            [self.list addObject:[[[Custom_itemTable alloc]init]fromJSON:item]];
    }   
    self.pageInfo =[[PageInfoData new]fromJSON:JSON[@"pageInfo"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    NSMutableArray *listList = [NSMutableArray new];
        for (Custom_itemTable *item in self.list)
            [listList addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"list\":[%@]",[listList componentsJoinedByString:@","]]];
    if(self.pageInfo!=nil){
        [res addObject:[NSString stringWithFormat:@"\"pageInfo\":%@",[self.pageInfo toJSON]]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end