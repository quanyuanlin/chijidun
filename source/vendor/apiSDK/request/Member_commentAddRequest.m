/*
不要手动修改
*/
#import "Member_commentAddRequest.h"

@implementation Member_commentAddRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    NSMutableArray *imgsArray =[self arrayFormat:JSON[@"imgs"]];
    self.imgs=[NSMutableArray new];
    if (imgsArray && imgsArray.count > 0) {
        for (NSString *item in imgsArray)  
            [self.imgs addObject:item];
    }  
    self.info = JSON[@"info"];
    self.mid = JSON[@"mid"];
    self.order_id = JSON[@"order_id"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    NSMutableArray *imgsList = [NSMutableArray new];
    for (NSString *item in self.imgs)  
        [imgsList addObject:[NSString stringWithFormat:@"\"%@\"",item]];
    [res addObject:[NSString stringWithFormat:@"\"imgs\":[%@]",[imgsList componentsJoinedByString:@","]]];    
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.mid!=nil){
        [res addObject:[self JSONItemFormat:@"\"mid\":\"%@\"" data:self.mid]];
    }
    if(self.order_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_id\":\"%@\"" data:self.order_id]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end