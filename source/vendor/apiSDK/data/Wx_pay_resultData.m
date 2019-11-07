/*
不要手动修改
*/
#import "Wx_pay_resultData.h"

@implementation Wx_pay_resultData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.appid = [self stringFormat:JSON[@"appid"]];
    self.noncestr = [self stringFormat:JSON[@"noncestr"]];
    self.package = [self stringFormat:JSON[@"package"]];
    self.partnerid = [self stringFormat:JSON[@"partnerid"]];
    self.prepayid = [self stringFormat:JSON[@"prepayid"]];
    self.sign = [self stringFormat:JSON[@"sign"]];
    self.signstr = [self stringFormat:JSON[@"signstr"]];
    self.timestamp = [self stringFormat:JSON[@"timestamp"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.appid!=nil){
        [res addObject:[self JSONItemFormat:@"\"appid\":\"%@\"" data:self.appid]];
    }
    if(self.noncestr!=nil){
        [res addObject:[self JSONItemFormat:@"\"noncestr\":\"%@\"" data:self.noncestr]];
    }
    if(self.package!=nil){
        [res addObject:[self JSONItemFormat:@"\"package\":\"%@\"" data:self.package]];
    }
    if(self.partnerid!=nil){
        [res addObject:[self JSONItemFormat:@"\"partnerid\":\"%@\"" data:self.partnerid]];
    }
    if(self.prepayid!=nil){
        [res addObject:[self JSONItemFormat:@"\"prepayid\":\"%@\"" data:self.prepayid]];
    }
    if(self.sign!=nil){
        [res addObject:[self JSONItemFormat:@"\"sign\":\"%@\"" data:self.sign]];
    }
    if(self.signstr!=nil){
        [res addObject:[self JSONItemFormat:@"\"signstr\":\"%@\"" data:self.signstr]];
    }
    if(self.timestamp!=nil){
        [res addObject:[self JSONItemFormat:@"\"timestamp\":\"%@\"" data:self.timestamp]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end