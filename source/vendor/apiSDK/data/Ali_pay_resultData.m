/*
不要手动修改
*/
#import "Ali_pay_resultData.h"

@implementation Ali_pay_resultData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.orderString = [self stringFormat:JSON[@"orderString"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.orderString!=nil){
        [res addObject:[self JSONItemFormat:@"\"orderString\":\"%@\"" data:self.orderString]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end