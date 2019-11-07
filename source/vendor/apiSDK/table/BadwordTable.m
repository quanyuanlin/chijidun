/*
不要手动修改
*/
#import "BadwordTable.h"

@implementation BadwordTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.add_time = [self stringFormat:JSON[@"add_time"]];
    self.badword = [self stringFormat:JSON[@"badword"]];
    self.Id = [self stringFormat:JSON[@"id"]];
    self.replaceword = [self stringFormat:JSON[@"replaceword"]];
    self.word_type = [self stringFormat:JSON[@"word_type"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.add_time!=nil){
        [res addObject:[self JSONItemFormat:@"\"add_time\":\"%@\"" data:self.add_time]];
    }
    if(self.badword!=nil){
        [res addObject:[self JSONItemFormat:@"\"badword\":\"%@\"" data:self.badword]];
    }
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.replaceword!=nil){
        [res addObject:[self JSONItemFormat:@"\"replaceword\":\"%@\"" data:self.replaceword]];
    }
    if(self.word_type!=nil){
        [res addObject:[self JSONItemFormat:@"\"word_type\":\"%@\"" data:self.word_type]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end