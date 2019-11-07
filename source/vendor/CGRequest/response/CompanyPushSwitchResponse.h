//
//  CompanyPushSwitchResponse.h
//  chijidun
//
//  Created by iMac on 16/9/2.
//
//

#import <Foundation/Foundation.h>

@interface CompanyPushSwitchResponse : NSObject

@property(nonatomic,strong) NSString *data;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;


@end
