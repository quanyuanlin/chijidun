//
//  SaveOrderRequest.h
//  chijidun
//
//  Created by iMac on 16/9/27.
//
//

#import <Foundation/Foundation.h>

@interface SaveOrderRequest : NSObject

@property(nonatomic,strong)NSString *items;
@property(nonatomic,strong)NSString *mealType;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *addrId;

@end
