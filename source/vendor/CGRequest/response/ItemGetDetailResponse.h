//
//  ItemGetDetailResponse.h
//  chijidun
//
//  Created by iMac on 16/12/8.
//
//

#import <Foundation/Foundation.h>
#import "ChefItemTable.h"

@interface ItemGetDetailResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@property(nonatomic,strong) ChefItemTable *item;


@end
