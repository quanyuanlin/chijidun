/*
不要手动修改
*/
#import "Custom_itemAd_listData.h"

@implementation Custom_itemAd_listData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    NSMutableArray *ad_listArray =[self arrayFormat:JSON[@"ad_list"]];
    self.ad_list=[NSMutableArray new];
    if (ad_listArray && ad_listArray.count > 0) {
        for (NSMutableDictionary *item in ad_listArray)
            [self.ad_list addObject:[[[Ad_appTable alloc]init]fromJSON:item]];
    }   
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    NSMutableArray *ad_listList = [NSMutableArray new];
        for (Ad_appTable *item in self.ad_list)
            [ad_listList addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"ad_list\":[%@]",[ad_listList componentsJoinedByString:@","]]];
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end