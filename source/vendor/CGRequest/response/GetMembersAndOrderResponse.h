//
//  GetMembersAndOrderResponse.h
//  chijidun
//
//  Created by iMac on 16/9/22.
//
//

#import <Foundation/Foundation.h>
#import "ChefTable.h"
#import "TeamOrderTable.h"
#import "ChefItemTable.h"

@class ChefTable;
@interface GetMembersAndOrderResponse : NSObject

+ (instancetype)withCGResponse:(CGResponse *)response;
- (instancetype)initWithCGResponse:(CGResponse *)response;

@property(nonatomic,strong) NSString *disable; //是否禁用点餐
@property(nonatomic,strong) NSString *timeDisable; //0不限制,1只限制私厨，2全限制
@property(nonatomic,strong) NSString *payType;  //0企业1个人2企业+个人
@property(nonatomic,strong) NSString *charge;  //餐标

@property(nonatomic,strong) NSArray/*ChefTable*/ *listCook;
@property(nonatomic,strong) NSArray/*ChefTable*/ *listRest;

@property(nonatomic,strong) TeamOrderTable *order;

@end
