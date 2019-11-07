//
//  MemberSearchResponse.h
//  chijidun
//
//  Created by iMac on 16/12/8.
//
//

#import <Foundation/Foundation.h>
#import "MemberListsData.h"

@interface MemberSearchResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@property(nonatomic,strong)MemberListsData *data;

@end
