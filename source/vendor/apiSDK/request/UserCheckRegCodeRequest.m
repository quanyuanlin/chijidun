//
//  UserCheckRegCodeRequest.m
//  chijidun
//
//  Created by iMac on 16/12/19.
//
//

#import "UserCheckRegCodeRequest.h"

@implementation UserCheckRegCodeRequest

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }
    self.tele = JSON[@"tele"];
    self.code = JSON[@"code"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.tele!=nil){
        [res addObject:[self JSONItemFormat:@"\"tele\":\"%@\"" data:self.tele]];
    }
    if(self.code!=nil){
        [res addObject:[self JSONItemFormat:@"\"code\":\"%@\"" data:self.code]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}


@end
