/*
不要手动修改
*/
#import "Ad_itemData.h"

@implementation Ad_itemData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.adclicktype = [self stringFormat:JSON[@"adclicktype"]];
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.app_type = [self stringFormat:JSON[@"app_type"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.adclicktype!=nil){
        [res addObject:[self JSONItemFormat:@"\"adclicktype\":\"%@\"" data:self.adclicktype]];
    }
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.app_type!=nil){
        [res addObject:[self JSONItemFormat:@"\"app_type\":\"%@\"" data:self.app_type]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end