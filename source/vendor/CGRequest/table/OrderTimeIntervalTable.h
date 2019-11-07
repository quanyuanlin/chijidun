//
//  OrderTimeIntervalTable.h
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import <Foundation/Foundation.h>

@interface OrderTimeIntervalTable : NSObject

@property(nonatomic,strong) NSString *week;
@property(nonatomic,strong) NSString *date;
@property(nonatomic,strong) NSString *month;
@property(nonatomic,strong) NSString *day;
@property(nonatomic,strong) NSString *exist;
@property(nonatomic,strong) NSString *disable;
@property(nonatomic,strong) NSArray *list;

@end
