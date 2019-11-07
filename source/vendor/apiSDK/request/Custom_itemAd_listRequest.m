/*
不要手动修改
*/
#import "Custom_itemAd_listRequest.h"

@implementation Custom_itemAd_listRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.type = JSON[@"type"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end