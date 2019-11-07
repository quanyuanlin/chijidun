//
//  ServiceOpenAreaListResponse.h
//  chijidun
//
//  Created by iMac on 16/11/18.
//
//

#import <Foundation/Foundation.h>

@interface ServiceOpenAreaListResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@property(nonatomic,strong)NSArray *list;


@end
