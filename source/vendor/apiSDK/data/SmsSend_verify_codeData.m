/*
不要手动修改
*/
#import "SmsSend_verify_codeData.h"

@implementation SmsSend_verify_codeData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.code = [self stringFormat:JSON[@"code"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.code!=nil){
        [res addObject:[self JSONItemFormat:@"\"code\":\"%@\"" data:self.code]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end