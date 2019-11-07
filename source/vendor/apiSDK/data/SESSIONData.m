/*
不要手动修改
*/
#import "SESSIONData.h"

@implementation SESSIONData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.member_type = [self stringFormat:JSON[@"member_type"]];
    self.token = [self stringFormat:JSON[@"token"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    self.username = [self stringFormat:JSON[@"username"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.member_type!=nil){
        [res addObject:[self JSONItemFormat:@"\"member_type\":\"%@\"" data:self.member_type]];
    }
    if(self.token!=nil){
        [res addObject:[self JSONItemFormat:@"\"token\":\"%@\"" data:self.token]];
    }
    if(self.uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"uid\":\"%@\"" data:self.uid]];
    }
    if(self.username!=nil){
        [res addObject:[self JSONItemFormat:@"\"username\":\"%@\"" data:self.username]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end