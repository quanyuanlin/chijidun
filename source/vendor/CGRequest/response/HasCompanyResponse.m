//
//  HasCompanyResponse.m
//  chijidun
//
//  Created by iMac on 16/9/21.
//
//

#import "HasCompanyResponse.h"

@implementation HasCompanyResponse

+ (instancetype)withCGResponse:(CGResponse *)response
{
    return [[self alloc] initWithCGResponse:response];
}
- (instancetype)initWithCGResponse:(CGResponse *)response
{
    if (self = [super init]) {        
        self.apply=response.data[@"apply"];
        self.has=response.data[@"has"];
        self.status=response.data[@"status"];
    }
    return self;
}


@end
