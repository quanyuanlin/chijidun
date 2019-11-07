/*
不要手动修改
*/
#import "Custom_logTable.h"

@implementation Custom_logTable 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.Id = [self stringFormat:JSON[@"id"]];
    self.num = [self stringFormat:JSON[@"num"]];
    self.pos_lat = [self stringFormat:JSON[@"pos_lat"]];
    self.pos_lng = [self stringFormat:JSON[@"pos_lng"]];
    self.stime = [self stringFormat:JSON[@"stime"]];
    self.tele = [self stringFormat:JSON[@"tele"]];
    self.type = [self stringFormat:JSON[@"type"]];
    self.uid = [self stringFormat:JSON[@"uid"]];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.Id!=nil){
        [res addObject:[self JSONItemFormat:@"\"id\":\"%@\"" data:self.Id]];
    }
    if(self.num!=nil){
        [res addObject:[self JSONItemFormat:@"\"num\":\"%@\"" data:self.num]];
    }
    if(self.pos_lat!=nil){
        [res addObject:[self JSONItemFormat:@"\"pos_lat\":\"%@\"" data:self.pos_lat]];
    }
    if(self.pos_lng!=nil){
        [res addObject:[self JSONItemFormat:@"\"pos_lng\":\"%@\"" data:self.pos_lng]];
    }
    if(self.stime!=nil){
        [res addObject:[self JSONItemFormat:@"\"stime\":\"%@\"" data:self.stime]];
    }
    if(self.tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"tele\":\"%@\"" data:self.tele]];
    }
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    if(self.uid!=nil){
        [res addObject:[self JSONItemFormat:@"\"uid\":\"%@\"" data:self.uid]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end