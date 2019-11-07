//
//  TeamOrderIndexResponse.h
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import <Foundation/Foundation.h>
#import "OrderIndexTable.h"
#import "CompanyTable.h"

@class OrderIndexTable;
@class CompanyTable;
@interface TeamOrderIndexResponse : NSObject

@property(nonatomic,strong) OrderIndexTable *item;
@property(nonatomic,strong) CompanyTable *company;

@property(nonatomic,strong) NSArray/*OrderIndexTable*/ *lists;


+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@end
