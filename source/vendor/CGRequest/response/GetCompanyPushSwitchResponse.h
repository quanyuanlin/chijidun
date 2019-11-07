//
//  GetCompanyPushSwitchResponse.h
//  chijidun
//
//  Created by iMac on 16/9/2.
//
//

#import <Foundation/Foundation.h>
#import "SwitchTable.h"
@interface GetCompanyPushSwitchResponse : NSObject

@property(nonatomic,strong) SwitchTable *data;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;


@end
