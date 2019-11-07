//
//  StartUpVersionResponse.h
//  chijidun
//
//  Created by iMac on 16/9/2.
//
//

#import <Foundation/Foundation.h>
#import "VersionTable.h"

@class VersionTable;
@interface StartUpVersionResponse : NSObject

@property(nonatomic,strong) VersionTable *data;

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@end
