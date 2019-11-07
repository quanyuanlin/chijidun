/*
不要手动修改
*/
#import "SettingTable.h"

@implementation SettingTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.data = [self stringFormat:JSON[@"data"]];
    self.name = [self stringFormat:JSON[@"name"]];
    self.remark = [self stringFormat:JSON[@"remark"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.data!=nil){
        [res addObject:[self JSONItemFormat:@"\"data\":\"%@\"" data:self.data]];
    }
    if(self.name!=nil){
        [res addObject:[self JSONItemFormat:@"\"name\":\"%@\"" data:self.name]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end