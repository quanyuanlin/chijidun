//
//  OrderGetMenuResponse.h
//  chijidun
//
//  Created by iMac on 16/9/23.
//
//

#import <Foundation/Foundation.h>

#import "ChefTable.h"
#import "ChefItemTable.h"
@interface OrderGetMenuResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@property(nonatomic,strong) NSArray/*ChefTable*/ *list;

@end
