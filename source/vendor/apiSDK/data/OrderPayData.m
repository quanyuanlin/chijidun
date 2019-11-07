/*
不要手动修改
*/
#import "OrderPayData.h"

@implementation OrderPayData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.ali_pay_result =[[Ali_pay_resultData new]fromJSON:JSON[@"ali_pay_result"]];
    self.pays = [self stringFormat:JSON[@"pays"]];
    self.wx_pay_result =[[Wx_pay_resultData new]fromJSON:JSON[@"wx_pay_result"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.ali_pay_result!=nil){
        [res addObject:[NSString stringWithFormat:@"\"ali_pay_result\":%@",[self.ali_pay_result toJSON]]];
    }
    if(self.pays!=nil){
        [res addObject:[self JSONItemFormat:@"\"pays\":\"%@\"" data:self.pays]];
    }
    if(self.wx_pay_result!=nil){
        [res addObject:[NSString stringWithFormat:@"\"wx_pay_result\":%@",[self.wx_pay_result toJSON]]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end