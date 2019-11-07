/*
不要手动修改
*/
#import "Admin_authTable.h"

@implementation Admin_authTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.menu_id = [self stringFormat:JSON[@"menu_id"]];
    self.role_id = [self stringFormat:JSON[@"role_id"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.menu_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"menu_id\":\"%@\"" data:self.menu_id]];
    }
    if(self.role_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"role_id\":\"%@\"" data:self.role_id]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end