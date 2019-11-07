/*
不要手动修改
*/
#import "Custom_itemIndexData.h"

@implementation Custom_itemIndexData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    NSMutableArray *ad_list1Array =[self arrayFormat:JSON[@"ad_list1"]];
    self.ad_list1=[NSMutableArray new];
    if (ad_list1Array && ad_list1Array.count > 0) {
        for (NSMutableDictionary *item in ad_list1Array)
            [self.ad_list1 addObject:[[[Ad_appTable alloc]init]fromJSON:item]];
    }   
    NSMutableArray *ad_list2Array =[self arrayFormat:JSON[@"ad_list2"]];
    self.ad_list2=[NSMutableArray new];
    if (ad_list2Array && ad_list2Array.count > 0) {
        for (NSMutableDictionary *item in ad_list2Array)
            [self.ad_list2 addObject:[[[Ad_appTable alloc]init]fromJSON:item]];
    }   
    NSMutableArray *ad_list3Array =[self arrayFormat:JSON[@"ad_list3"]];
    self.ad_list3=[NSMutableArray new];
    if (ad_list3Array && ad_list3Array.count > 0) {
        for (NSMutableDictionary *item in ad_list3Array)
            [self.ad_list3 addObject:[[[Ad_appTable alloc]init]fromJSON:item]];
    }   
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    NSMutableArray *ad_list1List = [NSMutableArray new];
        for (Ad_appTable *item in self.ad_list1)
            [ad_list1List addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"ad_list1\":[%@]",[ad_list1List componentsJoinedByString:@","]]];
    NSMutableArray *ad_list2List = [NSMutableArray new];
        for (Ad_appTable *item in self.ad_list2)
            [ad_list2List addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"ad_list2\":[%@]",[ad_list2List componentsJoinedByString:@","]]];
    NSMutableArray *ad_list3List = [NSMutableArray new];
        for (Ad_appTable *item in self.ad_list3)
            [ad_list3List addObject:[item toJSON]];
    [res addObject:[NSString stringWithFormat:@"\"ad_list3\":[%@]",[ad_list3List componentsJoinedByString:@","]]];
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end