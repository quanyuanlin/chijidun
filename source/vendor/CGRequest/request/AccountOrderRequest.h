//
//  AccountOrderRequest.h
//  chijidun
//
//  Created by iMac on 16/10/14.
//
//

#import <Foundation/Foundation.h>

@interface AccountOrderRequest : NSObject

@property(strong, nonatomic) NSString *page;
@property(strong, nonatomic) NSString *limit;
@property(strong, nonatomic) NSString *mealType;

@end
