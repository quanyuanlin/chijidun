/*
不要手动修改
*/
#import "OrderNeedCommentCountData.h"

@implementation OrderNeedCommentCountData 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.count = [self stringFormat:JSON[@"count"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.count!=nil){
        [res addObject:[self JSONItemFormat:@"\"count\":\"%@\"" data:self.count]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end