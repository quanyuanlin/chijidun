/*
不要手动修改
*/
#import "Member_commentListsData.h"

@implementation Member_commentListsData 

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
            [self.list addObject:[[[Member_commentTable alloc]init]fromJSON:item]];
    }   
    self.pageInfo =[[PageInfoData new]fromJSON:JSON[@"pageInfo"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    NSMutableArray *listList = [NSMutableArray new];
        for (Member_commentTable *item in self.list)
            [listList addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"list\":[%@]",[listList componentsJoinedByString:@","]]];
    if(self.pageInfo!=nil){
        [res addObject:[NSString stringWithFormat:@"\"pageInfo\":%@",[self.pageInfo toJSON]]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end