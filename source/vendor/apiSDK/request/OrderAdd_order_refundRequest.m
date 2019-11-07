/*
不要手动修改
*/
#import "OrderAdd_order_refundRequest.h"

@implementation OrderAdd_order_refundRequest 

- (instancetype)fromJSON:(NSMutableDictionary *) JSON
{          
    if([JSON isKindOfClass:[NSString class]]){return self;}
    if(JSON.count==0){
        JSON= [NSMutableDictionary new];
    }                 
    self.account = JSON[@"account"];
    self.alipay_name = JSON[@"alipay_name"];
    self.info = JSON[@"info"];
    self.order_id = JSON[@"order_id"];
    self.remark = JSON[@"remark"];
    self.type = JSON[@"type"];
    return self;
}

- (NSString *) toJSON
{
    NSMutableArray *res = [NSMutableArray new];
    if(self.account!=nil){
        [res addObject:[self JSONItemFormat:@"\"account\":\"%@\"" data:self.account]];
    }
    if(self.alipay_name!=nil){
        [res addObject:[self JSONItemFormat:@"\"alipay_name\":\"%@\"" data:self.alipay_name]];
    }
    if(self.info!=nil){
        [res addObject:[self JSONItemFormat:@"\"info\":\"%@\"" data:self.info]];
    }
    if(self.order_id!=nil){
        [res addObject:[self JSONItemFormat:@"\"order_id\":\"%@\"" data:self.order_id]];
    }
    if(self.remark!=nil){
        [res addObject:[self JSONItemFormat:@"\"remark\":\"%@\"" data:self.remark]];
    }
    if(self.type!=nil){
        [res addObject:[self JSONItemFormat:@"\"type\":\"%@\"" data:self.type]];
    }
    return [NSString stringWithFormat:@"{%@}",[res componentsJoinedByString:@","]];
}
@end