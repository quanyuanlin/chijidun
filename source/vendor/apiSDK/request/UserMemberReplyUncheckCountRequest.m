/*
不要手动修改
*/
#import "UserMemberReplyUncheckCountRequest.h"

@implementation UserMemberReplyUncheckCountRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end