//
//  SaveOrderResponse.m
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import "SaveOrderResponse.h"

@implementation SaveOrderResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {
        self.Id=response.data[@"Id"];
        self.code=response.code;
    }
    return self;
}



@end
