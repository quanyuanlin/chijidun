/*
不要手动修改
*/
#import "IndexGetData.h"

@implementation IndexGetData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    NSMutableArray *ad_listArray =[self arrayFormat:JSON[@"list"]];
    self.list=[NSMutableArray new];
    if (ad_listArray && ad_listArray.count > 0) {
        for (NSMutableDictionary *item in ad_listArray)
            [self.list addObject:[[[Ad_appTable alloc]init]fromJSON:item]];
    }   
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    NSMutableArray *list = [NSMutableArray new];
        for (Ad_appTable *item in self.list)
            [list addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"list\":[%@]",[list componentsJoinedByString:@","]]];
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end
