//
//  OrderConfirmOrderResponse.h
//  chijidun
//
//  Created by iMac on 16/11/16.
//
//

#import <Foundation/Foundation.h>
#import "QuanTable.h"
#import "RemarkTable.h"

@interface OrderConfirmOrderResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@property(nonatomic,strong)QuanTable  *quan;
@property(nonatomic,strong)MemberTable  *member;
@property(nonatomic,strong)NSArray  *time_list;
@property(nonatomic,strong)NSArray /*RemarkTable*/ *remark_list;

@end
